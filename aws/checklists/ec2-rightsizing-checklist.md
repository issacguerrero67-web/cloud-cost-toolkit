# EC2 Rightsizing Checklist

> **Cloud Cost Toolkit** | aws/checklists/
> Applies to: Startups ($500–3k/mo) and growing SaaS teams ($3k–15k/mo)
> Review cadence: Monthly (startups), Bi-weekly (SaaS teams)

---

## 🔍 Phase 1: Inventory & Baseline (Do This First)

- [ ] Export all running EC2 instances from Cost Explorer → Group by **Instance Type**
- [ ] Note each instance: Name, Type, Region, Monthly Cost, Attached to ASG? (Y/N)
- [ ] Pull **CloudWatch CPU metrics** for last 30 days (avg + max)
- [ ] Pull **CloudWatch NetworkIn/Out** for last 30 days
- [ ] Check **Memory utilization** (requires CloudWatch agent — if not installed, flag it)

> 💡 **Quick filter:** Any instance averaging <20% CPU over 30 days is a rightsizing candidate.

---

## ⚡ Phase 2: Quick Wins (Low Effort, Immediate Savings)

### Idle & Stopped Instances

- [ ] List all **stopped instances** — are they stopped >7 days? Terminate or snapshot+terminate
- [ ] List all instances with **0 network activity** in last 14 days
- [ ] Check for **dev/test instances** running 24/7 — should have a stop schedule

### Oversized Instances

- [ ] Flag any instance with **avg CPU <20%** — candidate to downsize one tier
- [ ] Flag any instance with **avg CPU <10%** — candidate to downsize two tiers or go Graviton
- [ ] Check `t3.medium` or larger running non-bursty workloads → consider `t4g` (Graviton, ~20% cheaper)

### Unattached Resources (Often Missed)

- [ ] **Unattached EBS volumes** — EC2 → Volumes → filter "available"
- [ ] **Unassociated Elastic IPs** — costs $0.005/hr each, adds up fast
- [ ] **Unused ENIs** sitting around after terminated instances

---

## 📊 Phase 3: Purchase Model Audit

### On-Demand vs Savings Plans

- [ ] Identify instances running **>720 hrs/month** (always-on) → Reserved or Savings Plan candidate
- [ ] Check **Savings Plans utilization** in Cost Explorer — below 90%? You over-committed
- [ ] Check **Reserved Instance utilization** — unused RIs are pure waste

### Spot Opportunity Check

- [ ] Are any batch jobs, data processing, or non-critical workloads running On-Demand?
- [ ] Dev/test environments → strong Spot candidates (with proper interruption handling)

> 💡 **Rule of thumb:** Always-on prod = Savings Plan. Interruptible workloads = Spot. Everything else = On-Demand until proven otherwise.

---

## 🏗️ Phase 4: Architecture Flags (SaaS Teams)

- [ ] Any single large instance doing work that could be split across smaller ones?
- [ ] Are Auto Scaling Groups configured with **appropriate min/max**? Min=0 for non-prod
- [ ] Are **scheduled scaling actions** set for predictable traffic patterns?
- [ ] Lambda or Fargate viable alternative for any always-on low-traffic instances?

---

## 🏷️ Phase 5: Tagging Compliance

- [ ] Every instance has: `Environment` (prod/staging/dev), `Owner`, `Project`, `CostCenter`
- [ ] Untagged instances flagged for owner identification
- [ ] Tag-based cost allocation enabled in Billing preferences

> ⚠️ Without tags you can't attribute cost. This is non-negotiable before scaling.

---

## 📋 Findings Tracker


| Instance ID | Type      | Avg CPU % | Monthly Cost | Issue            | Recommended Action   | Est. Savings |
| ----------- | --------- | --------- | ------------ | ---------------- | -------------------- | ------------ |
| i-xxxxxxxx  | t3.large  | 8%        | $60/mo       | Oversized        | Downsize to t3.small | ~$45/mo      |
| i-xxxxxxxx  | m5.xlarge | 15%       | $140/mo      | Savings Plan gap | Convert to 1yr SP    | ~$42/mo      |


---

## 💰 Savings Summary


| Category        | Instances Found | Estimated Monthly Savings |
| --------------- | --------------- | ------------------------- |
| Idle/stopped    |                 |                           |
| Oversized       |                 |                           |
| Purchase model  |                 |                           |
| Spot candidates |                 |                           |
| **Total**       |                 | **$**                     |


---

## ✅ After the Audit

- [ ] Document all changes in your change log before modifying anything in prod
- [ ] Test downsize on dev/staging first
- [ ] Set a **Budget Alert** if not already configured (see `aws/terraform/`)
- [ ] Schedule next review date: ___________

---

*Cloud Cost Toolkit — github.com/issacguerrero67-web/cloud-cost-toolkit*