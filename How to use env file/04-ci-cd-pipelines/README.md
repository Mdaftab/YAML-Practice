# CI/CD Pipelines with Environment Variables

This example shows how to use environment variables in CI/CD pipelines (GitHub Actions, GitLab CI, etc.).

## Structure

```
04-ci-cd-pipelines/
├── .github/workflows/
│   └── deploy.yaml          # GitHub Actions workflow
├── .env.staging             # Staging environment variables
├── .env.production           # Production environment variables
└── README.md                 # This file
```

## How It Works

CI/CD platforms use **Secrets** and **Variables** to store environment-specific values:
- **Secrets**: Sensitive data (passwords, API keys)
- **Variables**: Non-sensitive configuration

## GitHub Actions

### Setting Up Secrets

1. Go to repository Settings → Secrets and variables → Actions
2. Add secrets:
   - `PROD_DB_URL`
   - `PROD_API_KEY`
   - `STAGING_DB_URL`
   - `STAGING_API_KEY`

### Using in Workflow

```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}

steps:
  - name: Deploy
    env:
      DB_URL: ${{ secrets.DB_URL }}
    run: ./deploy.sh
```

## GitLab CI

### .gitlab-ci.yaml Example:
```yaml
stages:
  - deploy

deploy_production:
  stage: deploy
  script:
    - echo "Deploying with $PROD_API_KEY"
  environment:
    name: production
  variables:
    PROD_API_KEY: $PROD_API_KEY  # From GitLab CI/CD Variables
```

## Benefits

- ✅ Secrets stored securely in CI/CD platform
- ✅ Different values per environment/branch
- ✅ No secrets in code or logs
- ✅ Easy to rotate secrets

## Common Patterns

1. **Environment-specific deployments**
2. **Feature flags per branch**
3. **Different API endpoints per stage**
4. **Database connections per environment**

