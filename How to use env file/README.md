# How to Use Environment Variables with YAML Files

This directory contains comprehensive examples demonstrating real-world use cases for using environment variables with YAML configuration files.

## 📁 Directory Structure

```
How to use env file/
├── 01-multi-environment/          # Dev, Staging, Production configs
├── 02-docker-compose/             # Docker Compose with env vars
├── 03-kubernetes/                 # K8s ConfigMaps and Secrets
├── 04-ci-cd-pipelines/            # CI/CD pipeline configuration
├── 05-microservices/              # Microservices architecture
├── 06-infrastructure-as-code/     # Ansible, Terraform examples
├── 07-application-config/         # App config loading (Node.js, Python)
├── 08-feature-flags/              # Feature flag management
├── 09-secret-management/          # Secret management best practices
├── 10-dynamic-config/              # Runtime configuration changes
├── 11-multi-cloud/                 # AWS, Azure, GCP deployments
├── 12-local-development/           # Local dev setup
└── README.md                       # This file
```

## 🎯 Use Cases Covered

### 1. Multi-Environment Configuration
**Location**: `01-multi-environment/`

Use the same YAML template with different `.env` files for development, staging, and production.

**Key Features**:
- One template, multiple environments
- Environment-specific values
- Easy to add new environments

**Quick Start**:
```bash
cd 01-multi-environment
./process.sh development
./process.sh staging
./process.sh production
```

---

### 2. Docker Compose
**Location**: `02-docker-compose/`

Configure Docker Compose services with environment variables.

**Key Features**:
- Automatic variable substitution
- Support for `.env` files
- Different configs per environment

**Quick Start**:
```bash
cd 02-docker-compose
docker-compose --env-file .env up -d
```

---

### 3. Kubernetes
**Location**: `03-kubernetes/`

Use ConfigMaps and Secrets in Kubernetes deployments.

**Key Features**:
- ConfigMaps for non-sensitive data
- Secrets for sensitive data
- Create from `.env` files

**Quick Start**:
```bash
cd 03-kubernetes
./create-resources.sh
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
```

---

### 4. CI/CD Pipelines
**Location**: `04-ci-cd-pipelines/`

Use secrets and variables in CI/CD platforms (GitHub Actions, GitLab CI).

**Key Features**:
- Platform-native secret management
- Environment-specific deployments
- Secure variable handling

---

### 5. Microservices
**Location**: `05-microservices/`

Each microservice has its own configuration with environment variables.

**Key Features**:
- Service isolation
- Independent configuration
- Service-specific secrets

**Example Services**:
- `auth-service/` - Authentication service
- `payment-service/` - Payment processing service

---

### 6. Infrastructure as Code
**Location**: `06-infrastructure-as-code/`

Examples for Ansible, Terraform, and other IaC tools.

**Key Features**:
- Ansible playbooks with env vars
- Terraform variable files
- Automated infrastructure deployment

---

### 7. Application Configuration
**Location**: `07-application-config/`

Load YAML configuration in applications (Node.js, Python, etc.).

**Key Features**:
- Runtime config loading
- Environment variable substitution
- Language-specific examples

**Supported Languages**:
- Node.js
- Python

---

### 8. Feature Flags
**Location**: `08-feature-flags/`

Control feature activation using environment variables.

**Key Features**:
- Enable/disable features per environment
- A/B testing support
- Gradual rollouts

---

### 9. Secret Management
**Location**: `09-secret-management/`

Best practices for managing secrets with YAML and environment variables.

**Key Features**:
- `.env.example` template pattern
- `.gitignore` setup
- Security best practices

---

### 10. Dynamic Configuration
**Location**: `10-dynamic-config/`

Update configuration at runtime without code changes.

**Key Features**:
- Runtime updates
- Maintenance mode
- Quick incident response

---

### 11. Multi-Cloud Deployment
**Location**: `11-multi-cloud/`

Deploy the same application to different cloud providers.

**Supported Clouds**:
- AWS (`.env.aws`)
- Azure (`.env.azure`)
- Google Cloud Platform (`.env.gcp`)

---

### 12. Local Development
**Location**: `12-local-development/`

Optimized configuration for local development.

**Key Features**:
- Sensible defaults
- Mock API mode
- Debug logging
- Hot reload support

---

## 🚀 Quick Start Guide

### Basic Pattern

1. **Create YAML template** with `${VAR}` placeholders:
   ```yaml
   database:
     host: "${DB_HOST}"
     username: "${DB_USER}"
     password: "${DB_PASSWORD}"
   ```

2. **Create `.env` file** with values:
   ```bash
   DB_HOST=localhost
   DB_USER=myuser
   DB_PASSWORD=mypassword
   ```

3. **Process the template**:
   ```bash
   export $(cat .env | grep -v '^#' | xargs)
   envsubst < config.yaml.template > config.yaml
   ```

### Common Commands

```bash
# Load .env and process template
export $(cat .env | grep -v '^#' | xargs)
envsubst < template.yaml > output.yaml

# With Docker Compose
docker-compose --env-file .env up -d

# With Kubernetes
kubectl create secret generic my-secret --from-env-file=.env
```

---

## 🔒 Security Best Practices

1. **Never commit `.env` files** to version control
2. **Use `.env.example`** as a template (committed)
3. **Add `.env` to `.gitignore`**
4. **Use different secrets** per environment
5. **Rotate secrets** regularly
6. **Use secret management tools** (AWS Secrets Manager, HashiCorp Vault, etc.)

---

## 📚 Common Environment Variable Patterns

### Basic Substitution
```yaml
host: "${DB_HOST}"
```

### With Default Value
```yaml
port: "${DB_PORT:-5432}"
```

### In Docker Compose
```yaml
environment:
  - DATABASE_URL=${DATABASE_URL}
```

### In Kubernetes
```yaml
env:
  - name: DB_HOST
    valueFrom:
      configMapKeyRef:
        name: app-config
        key: db-host
```

### In GitHub Actions
```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
```

---

## 🛠️ Tools and Utilities

### Required Tools

- **envsubst**: For template substitution (usually comes with `gettext`)
  ```bash
  brew install gettext  # macOS
  apt-get install gettext-base  # Linux
  ```

- **Docker Compose**: For container orchestration
- **kubectl**: For Kubernetes deployments
- **yq**: For YAML processing (optional)

### Processing Scripts

Each example directory may include:
- `process.sh` - Template processing script
- `create-resources.sh` - Resource creation script
- Various utility scripts

---

## 📖 Learning Path

1. Start with **01-multi-environment** to understand the basics
2. Explore **07-application-config** for application integration
3. Check **02-docker-compose** for containerized apps
4. Review **03-kubernetes** for orchestration
5. Study **09-secret-management** for security practices
6. Explore other examples based on your needs

---

## 💡 Tips and Tricks

1. **Use defaults**: `${VAR:-default}` provides fallback values
2. **Validate variables**: Check if required vars are set before processing
3. **Comment your .env files**: Document what each variable does
4. **Use environment-specific files**: `.env.development`, `.env.production`, etc.
5. **Version control templates**: Keep `.yaml.template` files in git, not processed files

---

## 🔗 Related Resources

- [YAML Official Documentation](https://yaml.org/)
- [12-Factor App Methodology](https://12factor.net/config)
- [Docker Compose Environment Variables](https://docs.docker.com/compose/environment-variables/)
- [Kubernetes ConfigMaps and Secrets](https://kubernetes.io/docs/concepts/configuration/)

---

## 📝 Notes

- All `.env` files in examples are **templates** - replace with your actual values
- Scripts are provided for convenience but can be customized
- Examples are designed to be educational and may need adjustment for production use

---

Happy coding! 🎉

