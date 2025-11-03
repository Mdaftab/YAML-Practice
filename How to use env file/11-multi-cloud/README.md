# Multi-Cloud Deployment

Deploy the same application to different cloud providers (AWS, Azure, GCP) using different `.env` files.

## Usage

```bash
# AWS Deployment
export $(cat .env.aws | grep -v '^#' | xargs)
envsubst < config.yaml > config-aws.yaml

# Azure Deployment
export $(cat .env.azure | grep -v '^#' | xargs)
envsubst < config.yaml > config-azure.yaml

# GCP Deployment
export $(cat .env.gcp | grep -v '^#' | xargs)
envsubst < config.yaml > config-gcp.yaml
```

## Benefits

- ✅ Multi-cloud strategy
- ✅ Avoid vendor lock-in
- ✅ Disaster recovery
- ✅ Same codebase, different clouds

