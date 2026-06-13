# AWS Monthly Cost Review
> **Cloud Cost Toolkit** | aws/reports/
> Prepared by: Issac Guerrero | Cloud Cost Toolkit
> Contact: issacguerrero67@gmail.com

---

## Report Details

| Field | Value |
|-------|-------|
| **Client** | |
| **AWS Account(s)** | |
| **Review Period** | MM/YYYY |
| **Report Date** | |
| **Prepared By** | Issac Guerrero |
| **Next Review** | |

---

## 1. Executive Summary

> 2-3 sentences. Current spend state, biggest issue found, projected savings if recommendations are implemented.

**Example:**
*This account spent $X in [Month], a Y% increase from the prior month. The primary driver was oversized EC2 instances and three idle NAT Gateways running in non-production environments. Implementing the recommendations in this report is projected to reduce monthly spend by $X–$X within 30–90 days.*

---

## 2. Spend Overview

### Month-over-Month

| Month | Total Spend | vs Prior Month |
|-------|-------------|----------------|
| 3 months ago | $ | — |
| 2 months ago | $ | +/- % |
| Last month | $ | +/- % |
| **This month** | **$** | **+/- %** |

### Top Services by Cost

| Rank | Service | This Month | Last Month | Change | % of Bill |
|------|---------|------------|------------|--------|-----------|
| 1 | | $ | $ | +/- $ | % |
| 2 | | $ | $ | +/- $ | % |
| 3 | | $ | $ | +/- $ | % |
| 4 | | $ | $ | +/- $ | % |
| 5 | | $ | $ | +/- $ | % |

### Spend by Environment (if tagged)

| Environment | Spend | % of Total |
|-------------|-------|------------|
| Production | $ | % |
| Staging | $ | % |
| Dev/Test | $ | % |
| Untagged | $ | % |

> ⚠️ High untagged spend = cost attribution blind spot. See Section 6.

---

## 3. Key Findings

### 🔴 Critical (Act This Week)

| # | Finding | Service | Estimated Waste | Effort |
|---|---------|---------|-----------------|--------|
| 1 | | | $/mo | Low/Med/High |
| 2 | | | $/mo | |
| 3 | | | $/mo | |

### 🟡 Important (Act This Month)

| # | Finding | Service | Estimated Waste | Effort |
|---|---------|---------|-----------------|--------|
| 1 | | | $/mo | |
| 2 | | | $/mo | |

### 🟢 Optimization (Next Quarter)

| # | Finding | Service | Estimated Savings | Effort |
|---|---------|---------|-------------------|--------|
| 1 | | | $/mo | |
| 2 | | | $/mo | |

---

## 4. Detailed Analysis

### EC2 Compute

**Current State:**
- Total EC2 spend: $
- Instance count: 
- Purchase mix: % On-Demand / % Reserved / % Spot

**Findings:**

| Instance ID | Type | Avg CPU | Avg Memory | Monthly Cost | Recommendation | Projected Saving |
|-------------|------|---------|------------|--------------|----------------|-----------------|
| i-xxxxxxxx | | % | % | $ | | $ |

**Savings Plan / Reserved Instance Coverage:**
- Current SP utilization: %
- RI utilization: %
- Recommendation:

---

### Storage (S3 + EBS)

**S3:**
- Total buckets:
- Total storage cost: $
- Data transfer cost: $
- Findings:

**EBS:**
- Unattached volumes found:
- gp2 volumes (upgrade candidates):
- Total unattached volume cost: $

---

### Networking

| Resource | Count | Monthly Cost | Finding |
|----------|-------|--------------|---------|
| NAT Gateways | | $ | |
| Load Balancers | | $ | |
| Elastic IPs (unassociated) | | $ | |
| Data Transfer | | $ | |

---

### Database (RDS / Aurora / ElastiCache)

| Resource | Engine | Size | Utilization | Monthly Cost | Recommendation |
|----------|--------|------|-------------|--------------|----------------|
| | | | % | $ | |

---

## 5. 90-Day Action Plan

### Month 1 — Quick Wins (Target: $X savings)

- [ ] **Week 1:** Release X unassociated Elastic IPs → saves $X/mo
- [ ] **Week 1:** Delete/stop X idle resources → saves $X/mo
- [ ] **Week 2:** Rightsize X EC2 instances (dev/test first) → saves $X/mo
- [ ] **Week 2:** Convert X gp2 EBS volumes to gp3 → saves $X/mo
- [ ] **Week 3:** Deploy budget alerts (see aws/terraform/budget-alerts/) → $0 cost
- [ ] **Week 4:** Tag untagged resources → enables future tracking

### Month 2 — Structural Fixes (Target: $X savings)

- [ ] Purchase Savings Plan for always-on workloads → saves $X/mo
- [ ] Implement S3 lifecycle policies → saves $X/mo
- [ ] Schedule dev/test environment stop/start → saves $X/mo
- [ ] Set CloudWatch log retention policies → saves $X/mo

### Month 3 — Long-Term Optimization (Target: $X savings)

- [ ] Evaluate Graviton instance migration for eligible workloads
- [ ] Review Reserved Instance coverage and expiration dates
- [ ] Implement AWS Config rules for ongoing compliance
- [ ] Establish monthly cost review cadence

---

## 6. Tagging Compliance

| Tag Key | Coverage | Gap |
|---------|----------|-----|
| Environment | % | % untagged |
| Owner | % | % untagged |
| Project | % | % untagged |
| CostCenter | % | % untagged |

**Untagged spend this month: $**

> Untagged resources cannot be attributed to teams, projects, or cost centers.
> Recommendation: Enforce tagging via AWS Config or Service Control Policies.

---

## 7. Projected Savings Summary

| Timeframe | Action | Monthly Savings |
|-----------|--------|-----------------|
| Week 1–2 | Quick cleanup (IPs, idle resources) | $ |
| Week 3–4 | EC2 rightsizing | $ |
| Month 2 | Savings Plans / scheduling | $ |
| Month 3 | Architecture optimization | $ |
| **Total projected** | | **$X – $X/mo** |

**Annualized savings potential: $X – $X**
**Report fee ROI: Xmo payback period**

---

## 8. Recommendations Summary

| Priority | Action | Owner | Due Date | Status |
|----------|--------|-------|----------|--------|
| 🔴 High | | | | Not Started |
| 🔴 High | | | | Not Started |
| 🟡 Medium | | | | Not Started |
| 🟡 Medium | | | | Not Started |
| 🟢 Low | | | | Not Started |

---

## 9. Toolkit Resources Used

> Reference which Cloud Cost Toolkit templates were used in this audit.

- [ ] `aws/checklists/ec2-rightsizing-checklist.md`
- [ ] `aws/checklists/unused-resource-cleanup.md`
- [ ] `aws/terraform/budget-alerts/` — deployed / recommended
- [ ] `guides/audit-prompt-library.md`

---

## 10. Notes & Next Steps

**Agreed next steps:**
1.
2.
3.

**Follow-up date:**

**Questions or concerns:**
> Contact issacguerrero67@gmail.com or reply to this report document.

---

*This report was prepared using the Cloud Cost Toolkit.*
*github.com/issacguerrero67-web/cloud-cost-toolkit*
*© 2026 Issac Guerrero — Cloud Cost Toolkit*
