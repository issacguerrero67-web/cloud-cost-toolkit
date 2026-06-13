terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3"
}

locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "cloud-cost-toolkit/budget-alerts"
      AccountName = var.account_name
    },
    var.tags
  )

  has_service_filter     = length(var.services) > 0
  has_cost_center_filter = var.cost_center_tag != ""
  has_slack              = var.slack_webhook_url != ""
}

# ─── SNS Topic for budget alerts ───────────────────────────────────────────────
resource "aws_sns_topic" "budget_alerts" {
  name = "${var.account_name}-budget-alerts"
  tags = local.module_tags
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# ─── Optional Slack Lambda ─────────────────────────────────────────────────────
resource "aws_sns_topic_subscription" "slack" {
  count     = local.has_slack ? 1 : 0
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "https"
  endpoint  = var.slack_webhook_url
}

# ─── SNS Topic Policy ──────────────────────────────────────────────────────────
resource "aws_sns_topic_policy" "budget_alerts" {
  arn = aws_sns_topic.budget_alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowBudgetsToPublish"
        Effect = "Allow"
        Principal = {
          Service = "budgets.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.budget_alerts.arn
      }
    ]
  })
}

# ─── AWS Budget ────────────────────────────────────────────────────────────────
resource "aws_budgets_budget" "monthly" {
  name         = "${var.account_name}-monthly-budget"
  budget_type  = "COST"
  time_unit    = "MONTHLY"
  limit_amount = tostring(var.monthly_budget_amount)
  limit_unit   = var.currency

  # Optional: scope to specific services
  dynamic "cost_filter" {
    for_each = local.has_service_filter ? [1] : []
    content {
      name   = "Service"
      values = var.services
    }
  }

  # Optional: scope to a cost center tag
  dynamic "cost_filter" {
    for_each = local.has_cost_center_filter ? [1] : []
    content {
      name   = "TagKeyValue"
      values = ["CostCenter$${var.cost_center_tag}"]
    }
  }

  # Generate one notification per threshold
  dynamic "notification" {
    for_each = var.alert_thresholds
    content {
      comparison_operator       = notification.value <= 100 ? "GREATER_THAN" : "GREATER_THAN"
      threshold                 = notification.value
      threshold_type            = "PERCENTAGE"
      notification_type         = notification.value <= 100 ? "ACTUAL" : "FORECASTED"
      subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
    }
  }
}
