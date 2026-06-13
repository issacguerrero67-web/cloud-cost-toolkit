output "sns_topic_arn" {
  description = "ARN of the SNS topic receiving budget alerts"
  value       = aws_sns_topic.budget_alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic"
  value       = aws_sns_topic.budget_alerts.name
}

output "budget_name" {
  description = "Name of the AWS Budget created"
  value       = aws_budgets_budget.monthly.name
}

output "budget_limit" {
  description = "Monthly budget limit in USD"
  value       = "${var.monthly_budget_amount} ${var.currency}"
}

output "alert_thresholds" {
  description = "Configured alert thresholds"
  value       = var.alert_thresholds
}
