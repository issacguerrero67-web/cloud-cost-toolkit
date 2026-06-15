# Cloud Cost Toolkit

> Practitioner-built cost optimization templates, checklists, and Terraform modules for AWS. Built by a working cloud infrastructure enginee

---

## What's Inside

### Checklists


| File                                          | What It Covers                                                              |
| --------------------------------------------- | --------------------------------------------------------------------------- |
| `aws/checklists/ec2-rightsizing-checklist.md` | CPU/memory analysis, purchase model audit, Spot opportunities, tagging      |
| `aws/checklists/unused-resource-cleanup.md`   | NAT Gateways, idle LBs, unassociated EIPs, orphaned EBS/snapshots, idle RDS |


### Terraform Modules


| Module                         | What It Does                                                                     |
| ------------------------------ | -------------------------------------------------------------------------------- |
| `aws/terraform/budget-alerts/` | Monthly budget with SNS email alerts at 50/80/100/120% � deployable in 5 minutes |


### Report Templates


| File                                 | What It Covers                                                                            |
| ------------------------------------ | ----------------------------------------------------------------------------------------- |
| `aws/reports/monthly-cost-review.md` | Full audit report template: spend overview, findings, 90-day action plan, savings summary |


### Guides


| File                             | What It Covers                                        |
| -------------------------------- | ----------------------------------------------------- |
| `guides/audit-prompt-library.md` | AI prompt library for running cost audits efficiently |


---

## Who This Is For

- Startups and small teams on AWS with no dedicated FinOps engineer
- Developers and engineers who own their own cloud bill
- Anyone who just got hit with an unexpected AWS invoice
- Consultants and freelancers who want to deliver faster, better audits

---

## Quick Start

### Run your first audit in 30 minutes

1. Pull `aws/checklists/ec2-rightsizing-checklist.md` identify your biggest EC2 waste
2. Pull `aws/checklists/unused-resource-cleanup.md` kill idle resources immediately
3. Deploy `aws/terraform/budget-alerts/` never get surprised by your bill again
4. Fill out `aws/reports/monthly-cost-review.md` document findings and track savings

### Deploy budget alerts in 5 minutes

```hcl
module "budget_alerts" {
  source = "github.com/issacguerrero67-web/cloud-cost-toolkit//aws/terraform/budget-alerts"

  account_name          = "my-account"
  monthly_budget_amount = 500
  alert_email           = "you@yourcompany.com"
}
```

```bash
terraform init && terraform apply
```

---

## Roadmap

- [ ] EC2 rightsizing checklist
- [ ] Unused resource cleanup tracker
- [ ] Budget alerts Terraform module
- [ ] Monthly cost review report template
- [ ] AI audit prompt library
- [ ] S3 lifecycle policy templates
- [ ] Log retention Terraform module
- [ ] Tagging policy Terraform module
- [ ] RDS rightsizing checklist
- [ ] Case study library

---

## Need a Full Audit?

Don't have time to run this yourself?

I offer **AI-assisted AWS cost audits** delivered in 24-48 hours:

- Full account analysis using these templates
- Custom findings report with your actual numbers
- 90-day action plan with projected savings
- Terraform modules configured for your environment

**Starting at $300 per audit.**  
Book your audit: [https://bit.ly/aws-cost-audit](https://bit.ly/aws-cost-audit)  
Direct email: [issacguerrero67@gmail.com](mailto:issacguerrero67@gmail.com)

15-min discovery call: [https://calendly.com/issacguerrero67/aws-audit-call](https://calendly.com/issacguerrero67/aws-audit-call)

---

## License

MIT use freely, attribution appreciated.

---

*Built with real-world AWS migration experience.*  *2026 Issac Guerrero Cloud Cost Toolkit*