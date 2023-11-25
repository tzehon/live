Deploy on Cloud Run:
```
terraform plan
terraform apply
```

Test authenticated Cloud Run service locally:
```
 curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" `terraform output | awk -F'"' '{print $2}'`
```