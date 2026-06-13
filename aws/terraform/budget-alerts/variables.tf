variable "account_name" {
  description = "Human-readable name for this AWS account (used in alert messages)"
  type        = string
}

variable "monthly_budget_amount" {
  description = "Monthly budget limit in USD"
  type        = number
}

variable "alert_email" {
  description = "Email address to receive budget alerts"
  type        = string
}

variable "currency" {
  description = "Currency for budget (default: USD)"
  type        = string
  default     = "USD"
}

variable "alert_thresholds" {
  description = "List of percentage thresholds to trigger alerts"
  type        = list(number)
  default     = [50, 80, 100, 120]
}

variable "services" {
  description = "Optional list of AWS services to scope budget to. Empty = all services."
  type        = list(string)
  default     = []
}

variable "cost_center_tag" {
  description = "Optional cost center tag value to scope budget to a specific team/project"
  type        = string
  default     = ""
}

variable "slack_webhook_url" {
  description = "Optional Slack webhook URL for notifications (leave empty to disable)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}
