# Terraform Module: budget-alerts
> **Cloud Cost Toolkit** | aws/terraform/budget-alerts
> Deploy AWS Budget alerts in under 5 minutes.

---

## What This Does
- Creates a monthly AWS Budget for your account
- Fires SNS email alerts at configurable thresholds (default: 50%, 80%, 100%, 120%)
- Optionally scopes to specific services or cost center tags
- Optional Slack webhook support
- 100% Terraform managed, no console clicking required

---

## Requirements
- Terraform >= 1.3
- AWS Provider >= 5.0
- IAM permissions: `budgets:*`, `sns:*`

---

## Quick Start

```hcl
module "budget_alerts" {
  source = "github.com/issacguerrero67-web/cloud-cost-toolkit//aws/terraform/budget-alerts"

  account_name          = "my-startup-prod"
  monthly_budget_amount = 500
  alert_email           = "team@mycompany.com"
}
```

Deploy:
```bash
terraform init
terraform plan
terraform apply
```

**Done. You'll receive a confirmation email from AWS SNS — click confirm to activate alerts.**

---

## Advanced Usage

### Scope to specific services
```hcl
module "budget_alerts" {
  source = "github.com/issacguerrero67-web/cloud-cost-toolkit//aws/terraform/budget-alerts"

  account_name          = "my-startup-prod"
  monthly_budget_amount = 500
  alert_email           = "team@mycompany.com"

  services = ["Amazon EC2", "Amazon RDS", "Amazon S3"]
}
```

### Scope to a cost center tag
```hcl
module "budget_alerts" {
  source = "github.com/issacguerrero67-web/cloud-cost-toolkit//aws/terraform/budget-alerts"

  account_name          = "my-startup-prod"
  monthly_budget_amount = 200
  alert_email           = "backend-team@mycompany.com"
  cost_center_tag       = "backend"
}
```

### Custom thresholds + Slack
```hcl
module "budget_alerts" {
  source = "github.com/issacguerrero67-web/cloud-cost-toolkit//aws/terraform/budget-alerts"

  account_name          = "my-startup-prod"
  monthly_budget_amount = 1000
  alert_email           = "team@mycompany.com"
  alert_thresholds      = [75, 90, 100, 110]
  slack_webhook_url     = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
}
```

---

## Inputs

| Variable | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `account_name` | string | ✅ | — | Human-readable account name |
| `monthly_budget_amount` | number | ✅ | — | Budget limit in USD |
| `alert_email` | string | ✅ | — | Email for notifications |
| `currency` | string | ❌ | `USD` | Budget currency |
| `alert_thresholds` | list(number) | ❌ | `[50,80,100,120]` | Alert percentages |
| `services` | list(string) | ❌ | `[]` | Scope to AWS services |
| `cost_center_tag` | string | ❌ | `""` | Scope to cost center tag |
| `slack_webhook_url` | string | ❌ | `""` | Slack webhook (sensitive) |
| `tags` | map(string) | ❌ | `{}` | Tags for all resources |

## Outputs

| Output | Description |
|--------|-------------|
| `sns_topic_arn` | ARN of the alert SNS topic |
| `sns_topic_name` | Name of the SNS topic |
| `budget_name` | Name of the AWS Budget |
| `budget_limit` | Configured monthly limit |
| `alert_thresholds` | Active alert thresholds |

---

## IAM Policy Required

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["budgets:*", "sns:*"],
      "Resource": "*"
    }
  ]
}
```

---

*Cloud Cost Toolkit — github.com/issacguerrero67-web/cloud-cost-toolkit*
