# AWS Unused Resource Cleanup Tracker
> **Cloud Cost Toolkit** | aws/checklists/
> Applies to: All AWS account sizes
> Review cadence: Monthly — run this before your cost review meeting

---

## Why This Matters
Unused resources are pure waste — no business value, 100% cost. A single forgotten NAT Gateway
runs ~$32/mo. Three unassociated Elastic IPs = $10.80/mo. Orphaned snapshots from 2022?
Still billing you. This checklist finds and kills all of it.

---

## 🔴 Tier 1: High Cost, Easy to Find (Do These First)

### NAT Gateways
- [ ] Go to VPC → NAT Gateways → filter by state
- [ ] Any NAT GW with **0 bytes processed** in last 7 days → candidate for deletion
- [ ] Dev/test VPCs using NAT GW? → Replace with NAT Instance (~$4/mo vs $32+/mo)
- [ ] Single NAT GW serving multiple AZs in non-prod? → Acceptable tradeoff for cost

**Console path:** VPC → NAT Gateways
**CloudWatch metric:** `BytesOutToDestination` — 0 over 7 days = unused

| NAT GW ID | VPC | Bytes Processed (7d) | Monthly Cost | Action |
|-----------|-----|----------------------|--------------|--------|
| nat-xxxxx | | | ~$32+ | |

---

### Load Balancers (ALB/NLB/CLB)
- [ ] EC2 → Load Balancers → check **Request Count** metric for last 30 days
- [ ] 0 requests in 30 days → delete or flag for owner confirmation
- [ ] Check target groups — any with **no registered targets**?
- [ ] Idle CLBs (Classic) → strong deletion candidate, migrate to ALB if needed

**CloudWatch metric:** `RequestCount` (ALB), `ActiveFlowCount` (NLB)

| LB Name | Type | Requests (30d) | Monthly Cost | Action |
|---------|------|----------------|--------------|--------|
| | | | ~$16-18/mo base | |

---

### Elastic IPs
- [ ] EC2 → Elastic IPs → filter **Association ID = blank**
- [ ] Every unassociated EIP = $0.005/hr = **$3.60/mo each**
- [ ] Release any not actively needed — they're free when associated

**CLI shortcut:**
```bash
aws ec2 describe-addresses --query 'Addresses[?AssociationId==null].[PublicIp,AllocationId]' --output table
```

| Elastic IP | Allocation ID | Associated? | Monthly Cost | Action |
|------------|---------------|-------------|--------------|--------|
| | | No | $3.60 | Release |

---

## 🟡 Tier 2: Medium Cost, Slightly More Digging

### Unattached EBS Volumes
- [ ] EC2 → Volumes → filter **State = available**
- [ ] Available = not attached to any instance = billing you for nothing
- [ ] Snapshot before deleting anything you're unsure about
- [ ] gp2 volumes? → Convert survivors to gp3 (20% cheaper, better performance)

**CLI shortcut:**
```bash
aws ec2 describe-volumes --filters Name=status,Values=available --query 'Volumes[*].[VolumeId,Size,VolumeType,CreateTime]' --output table
```

| Volume ID | Size | Type | Age | Monthly Cost | Action |
|-----------|------|------|-----|--------------|--------|
| vol-xxxxx | 100GB | gp2 | | ~$10/mo | Snapshot → Delete |

---

### Orphaned Snapshots
- [ ] EC2 → Snapshots → filter **Owner = self**
- [ ] Sort by **Start time** ascending — anything older than 90 days review carefully
- [ ] Check if source volume still exists — if not, snapshot is likely orphaned
- [ ] Set a **retention policy** going forward (see aws/terraform/ for automation)

**CLI shortcut:**
```bash
aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[*].[SnapshotId,VolumeSize,StartTime,Description]' --output table
```

> ⚠️ Never delete snapshots without confirming they're not used by an AMI first.
> Check: `aws ec2 describe-images --filters Name=block-device-mapping.snapshot-id,Values=snap-xxxxx`

| Snapshot ID | Size | Age | Source Volume Exists? | Action |
|-------------|------|-----|-----------------------|--------|
| snap-xxxxx | 50GB | 18mo | No | Delete |

---

### Idle RDS Instances
- [ ] RDS → Databases → check **DatabaseConnections** metric last 30 days
- [ ] 0 connections in 30 days → stop or delete (stopped RDS still bills for storage)
- [ ] Dev/test RDS running 24/7? → Schedule stop/start or use Aurora Serverless v2

**CloudWatch metric:** `DatabaseConnections` — 0 over 14 days = idle

| DB Identifier | Engine | Connections (30d) | Monthly Cost | Action |
|---------------|--------|-------------------|--------------|--------|
| | | 0 | | Stop/Delete |

---

## 🟢 Tier 3: Lower Cost but Adds Up

### Unused Secrets Manager Secrets
- [ ] Secrets Manager → filter by **Last accessed**
- [ ] Not accessed in 90+ days → confirm with owner, delete if abandoned
- [ ] Cost: $0.40/secret/month — small per secret, adds up in large accounts

### Old CloudWatch Log Groups
- [ ] CloudWatch → Log Groups → sort by **Size**
- [ ] No retention policy set? → Set 30-90 day retention immediately
- [ ] Lambda log groups from deleted functions → safe to delete

```bash
# Find log groups with no retention set
aws logs describe-log-groups --query 'logGroups[?retentionInDays==null].[logGroupName,storedBytes]' --output table
```

### Unused ECR Images
- [ ] ECR → Repositories → check **Last pushed** date
- [ ] Images older than 90 days with no recent pulls → enable lifecycle policy
- [ ] Untagged images → almost always safe to delete

---

## 💰 Cleanup Summary

| Resource Type | Count Found | Est. Monthly Savings |
|---------------|-------------|----------------------|
| NAT Gateways | | |
| Load Balancers | | |
| Elastic IPs | | |
| EBS Volumes | | |
| Snapshots | | |
| RDS Instances | | |
| Other | | |
| **Total** | | **$** |

---

## ✅ Before You Delete Anything

- [ ] Tag owner identified and notified
- [ ] Snapshot taken for any storage resource
- [ ] Change logged with date and approver
- [ ] Verify no CloudFormation stack owns the resource (deletion will fail or cause drift)
- [ ] Schedule deletion during low-traffic window for anything in prod-adjacent accounts

---

## 🔁 Automate It Next

Once you've done this manually once, see `aws/terraform/` for:
- Snapshot lifecycle automation
- EIP release alerts
- CloudWatch log retention enforcement
- Idle resource tagging via AWS Config rules

---

*Cloud Cost Toolkit — github.com/issacguerrero67-web/cloud-cost-toolkit*
