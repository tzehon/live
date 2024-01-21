Create service account for Workload Identity Federation with these roles
```
Cloud Run Admin
Cloud Scheduler Admin
Compute Network Admin
Compute Viewer
Create Service Accounts
Secret Manager Admin
Serverless VPC Access Admin
Service Account Admin
Service Account Token Creator
Service Account User
Storage Admin
```

Setup Workload Identity federation
```
gcloud iam workload-identity-pools create "<POOL_NAME>" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

gcloud iam workload-identity-pools providers create-oidc "<{PROVIDER_NAME>}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="POOL_NAME" \
  --display-name="My GitHub repo Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"

gcloud iam service-accounts add-iam-policy-binding "<SA_NAME>@tth-prop-analysis.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/<PROJECT_NUMBER>/locations/global/workloadIdentityPools/<POOL_NAME>/attribute.repository/<USER>/<REPO_NAME>"

```

Test authenticated Cloud Run service locally:
```
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" `terraform output | awk -F'"' '{print $2}'`
```