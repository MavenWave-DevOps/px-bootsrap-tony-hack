# Project X Bootstrap

## End goal: have a cloud devops control plane in a GKE cluster.
# STEPS

1. Replace `GCP_PROJECT_ID`, `REPO_NAME` and `TENANT_CODE` with corresponding values (recommend using find and replace, since they show up very often)

2. Run Terraform code in `terraform/cluster` and `terraform/config` directory using TFE - currently running in [TFE](https://infra.mavenwave.net/app/infra-mavenwave/workspaces/project-x-bootstrap)

3. Go to argocd-TENANT_CODE.px.igniteme.dev to finish setting up your control plane cluster by syncing the ArgoCD applications

