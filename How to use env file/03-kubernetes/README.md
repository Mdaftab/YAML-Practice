# Kubernetes with Environment Variables - Complete Guide

This directory contains comprehensive examples showing how to use environment variables with Kubernetes deployments, including multi-environment setups and secret management.

## 📁 Directory Structure

```
03-kubernetes/
├── examples/
│   ├── simple/              # Simple env var usage
│   │   ├── deployment.yaml
│   │   ├── .env
│   │   └── create-from-env.sh
│   └── complex/             # Complex env var usage
│       ├── deployment.yaml
│       ├── .env
│       └── create-resources.sh
├── environments/             # Multi-environment deployments
│   ├── development/
│   │   ├── deployment.yaml
│   │   └── .env.development
│   ├── staging/
│   │   ├── deployment.yaml
│   │   └── .env.staging
│   ├── production/
│   │   ├── deployment.yaml
│   │   └── .env.production
│   └── deploy-all.sh        # Deploy all environments
├── secret-management/        # Secret deployment scripts
│   ├── deploy-secrets.sh     # Deploy secret from .env
│   ├── deploy-all-environments.sh
│   └── deploy-with-kustomize.sh
├── deployment.yaml          # Basic example
├── create-resources.sh       # Original script
└── README.md                 # This file
```

## 🚀 Quick Start

### Simple Example

```bash
cd examples/simple
./create-from-env.sh
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
```

### Complex Example

```bash
cd examples/complex
./create-resources.sh
kubectl apply -f .
```

### Multi-Environment Deployment

```bash
cd environments
./deploy-all.sh
```

### Deploy Secrets from .env File

```bash
cd secret-management
./deploy-secrets.sh development ../environments/development/.env.development
kubectl apply -f secret-development.yaml
```

## 📚 Examples Explained

### 1. Simple Example (`examples/simple/`)

**Purpose**: Learn the basics of using ConfigMaps and Secrets in Kubernetes.

**What it shows**:
- Basic ConfigMap creation
- Basic Secret creation
- Individual environment variable references
- Simple deployment configuration

**Key Concepts**:
- `configMapKeyRef` - Reference individual ConfigMap keys
- `secretKeyRef` - Reference individual Secret keys
- Direct value assignment

### 2. Complex Example (`examples/complex/`)

**Purpose**: Advanced patterns for production applications.

**What it shows**:
- Multiple ConfigMaps (app-config, feature-flags)
- Multiple Secrets (db-secrets, api-secrets, logging-secrets)
- `envFrom` for bulk loading
- Init containers with env vars
- Sidecar containers
- Optional vs required variables
- Field references (pod name, namespace)
- Resource limits
- Health checks

**Key Concepts**:
- `envFrom` - Load all keys from ConfigMap/Secret
- `optional: true/false` - Control required variables
- `fieldRef` - Reference pod metadata
- Multiple resource types

### 3. Multi-Environment Deployments (`environments/`)

**Purpose**: Deploy the same application to different environments (dev, staging, prod).

**What it shows**:
- Environment-specific namespaces
- Environment-specific ConfigMaps
- Environment-specific Secrets
- Different resource requirements per environment
- Different replica counts
- Environment labels

**Usage**:

```bash
# Deploy development
cd environments/development
kubectl create namespace development
kubectl create configmap myapp-dev-config --from-env-file=.env.development -n development
kubectl create secret generic myapp-dev-secrets --from-env-file=.env.development -n development
kubectl apply -f deployment.yaml

# Deploy staging
cd ../staging
kubectl create namespace staging
kubectl create configmap myapp-staging-config --from-env-file=.env.staging -n staging
kubectl create secret generic myapp-staging-secrets --from-env-file=.env.staging -n staging
kubectl apply -f deployment.yaml

# Deploy production
cd ../production
kubectl create namespace production
kubectl create configmap myapp-prod-config --from-env-file=.env.production -n production
kubectl create secret generic myapp-prod-secrets --from-env-file=.env.production -n production
kubectl apply -f deployment.yaml
```

### 4. Secret Management (`secret-management/`)

**Purpose**: Deploy secrets from .env files to Kubernetes.

**Scripts**:

1. **`deploy-secrets.sh`** - Deploy secrets for a single environment
   ```bash
   ./deploy-secrets.sh development .env.development
   kubectl apply -f secret-development.yaml
   ```

2. **`deploy-all-environments.sh`** - Deploy secrets for all environments
   ```bash
   ./deploy-all-environments.sh
   ```

3. **`deploy-with-kustomize.sh`** - Use Kustomize for secret management
   ```bash
   ./deploy-with-kustomize.sh development
   kubectl apply -k .
   ```

## 🔑 Key Concepts

### ConfigMap vs Secret

**ConfigMap** (for non-sensitive data):
- Log levels
- API endpoints
- Feature flags
- Configuration values

**Secret** (for sensitive data):
- Passwords
- API keys
- Tokens
- Database credentials

### Environment Variable Methods

#### Method 1: Individual References
```yaml
env:
- name: DB_HOST
  valueFrom:
    configMapKeyRef:
      name: app-config
      key: db-host
```

#### Method 2: Bulk Loading (envFrom)
```yaml
envFrom:
- configMapRef:
    name: app-config
- secretRef:
    name: app-secrets
```

#### Method 3: Direct Values
```yaml
env:
- name: APP_VERSION
  value: "1.0.0"
```

#### Method 4: Field References
```yaml
env:
- name: POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
```

## 📝 Creating Resources from .env Files

### Method 1: Direct kubectl Command

```bash
# Create ConfigMap
kubectl create configmap app-config \
  --from-env-file=.env

# Create Secret
kubectl create secret generic app-secrets \
  --from-env-file=.env
```

### Method 2: Using Scripts

```bash
# Simple example
cd examples/simple
./create-from-env.sh

# Complex example
cd examples/complex
./create-resources.sh

# Secret management
cd secret-management
./deploy-secrets.sh development
```

### Method 3: Manual YAML Creation

```bash
# Generate YAML
kubectl create configmap app-config \
  --from-env-file=.env \
  --dry-run=client -o yaml > configmap.yaml

kubectl create secret generic app-secrets \
  --from-env-file=.env \
  --dry-run=client -o yaml > secret.yaml
```

## 🔒 Security Best Practices

1. **Never commit secrets** to version control
2. **Use .env.example** as template (committed)
3. **Add .env files** to .gitignore
4. **Use proper secret management** in production:
   - AWS Secrets Manager
   - HashiCorp Vault
   - Azure Key Vault
   - Sealed Secrets
5. **Rotate secrets** regularly
6. **Use namespaces** to isolate environments
7. **Limit secret access** with RBAC

## 🎯 Common Use Cases

### Use Case 1: Single Environment
```bash
cd examples/simple
./create-from-env.sh
kubectl apply -f .
```

### Use Case 2: Multiple Environments
```bash
cd environments
./deploy-all.sh
```

### Use Case 3: Update Secrets
```bash
# Edit .env file
nano .env.production

# Recreate secret
kubectl delete secret myapp-prod-secrets -n production
kubectl create secret generic myapp-prod-secrets \
  --from-env-file=.env.production -n production

# Restart pods to pick up new secrets
kubectl rollout restart deployment/myapp-production -n production
```

### Use Case 4: Deploy from CI/CD
```bash
# In CI/CD pipeline
export $(cat .env.production | grep -v '^#' | xargs)
kubectl create configmap myapp-prod-config \
  --from-env-file=.env.production -n production \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f deployment.yaml
```

## 📖 Additional Resources

- [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Kustomize Documentation](https://kustomize.io/)
- [12-Factor App](https://12factor.net/config)

---

Happy deploying! 🚀
