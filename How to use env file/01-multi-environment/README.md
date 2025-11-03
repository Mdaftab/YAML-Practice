# Multi-Environment Configuration

This example demonstrates how to use the same YAML template with different `.env` files for multiple environments (development, staging, production).

## Structure

```
01-multi-environment/
├── config.yaml.template    # YAML template with ${VAR} placeholders
├── .env.development        # Development environment variables
├── .env.staging            # Staging environment variables
├── .env.production         # Production environment variables
├── process.sh              # Script to process templates
└── README.md              # This file
```

## How It Works

1. **Template File** (`config.yaml.template`): Contains YAML with `${VAR}` placeholders
2. **Environment Files** (`.env.*`): Each environment has its own `.env` file with specific values
3. **Processing**: Script loads `.env` file and substitutes variables into template

## Usage

### Process for Development:
```bash
./process.sh development
# Creates: config.development.yaml
```

### Process for Staging:
```bash
./process.sh staging
# Creates: config.staging.yaml
```

### Process for Production:
```bash
./process.sh production
# Creates: config.production.yaml
```

## Manual Processing

```bash
# Development
export $(cat .env.development | grep -v '^#' | xargs)
envsubst < config.yaml.template > config.development.yaml

# Staging
export $(cat .env.staging | grep -v '^#' | xargs)
envsubst < config.yaml.template > config.staging.yaml

# Production
export $(cat .env.production | grep -v '^#' | xargs)
envsubst < config.yaml.template > config.production.yaml
```

## Benefits

- ✅ One template, multiple environments
- ✅ No code changes needed for different environments
- ✅ Easy to add new environments
- ✅ Secure: secrets in `.env` files (not in code)

## Next Steps

After processing, use the generated YAML files:
- `config.development.yaml` - for local development
- `config.staging.yaml` - for staging deployments
- `config.production.yaml` - for production deployments

