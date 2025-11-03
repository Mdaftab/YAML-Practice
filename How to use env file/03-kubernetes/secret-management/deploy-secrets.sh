#!/bin/bash
# ============================================
# Deploy Secrets from .env File to Kubernetes
# ============================================
# This script reads .env file and creates Kubernetes Secret
# Usage: ./deploy-secrets.sh [environment] [.env-file]
# Example: ./deploy-secrets.sh development .env.development

ENVIRONMENT="${1:-development}"
ENV_FILE="${2:-.env.${ENVIRONMENT}}"
SECRET_NAME="myapp-${ENVIRONMENT}-secrets"
NAMESPACE="${ENVIRONMENT}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Deploying Secrets for: ${ENVIRONMENT}"
echo "=========================================="
echo ""

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ Error: $ENV_FILE not found!${NC}"
    echo ""
    echo "Available .env files:"
    ls -1 .env.* 2>/dev/null | sed 's/^/  /' || echo "  (none found)"
    exit 1
fi

# Check if namespace exists
echo "📦 Checking namespace: ${NAMESPACE}"
if ! kubectl get namespace "${NAMESPACE}" &>/dev/null; then
    echo -e "${YELLOW}⚠️  Namespace ${NAMESPACE} does not exist. Creating...${NC}"
    kubectl create namespace "${NAMESPACE}"
    echo -e "${GREEN}✅ Namespace ${NAMESPACE} created${NC}"
else
    echo -e "${GREEN}✅ Namespace ${NAMESPACE} exists${NC}"
fi

echo ""
echo "📄 Reading secrets from: ${ENV_FILE}"
echo ""

# Extract sensitive variables (commonly secret variables)
SENSITIVE_VARS=(
    "DATABASE_URL"
    "DB_PASSWORD"
    "API_KEY"
    "JWT_SECRET"
    "STRIPE_API_KEY"
    "STRIPE_WEBHOOK_SECRET"
    "AWS_ACCESS_KEY"
    "AWS_SECRET_KEY"
    "SMTP_PASSWORD"
    "REDIS_PASSWORD"
)

# Build kubectl create secret command
SECRET_ARGS=()

# Read .env file and extract variables
while IFS='=' read -r key value || [ -n "$key" ]; do
    # Skip comments and empty lines
    [[ "$key" =~ ^#.*$ ]] && continue
    [[ -z "$key" ]] && continue
    
    # Remove quotes if present
    value=$(echo "$value" | sed 's/^"//;s/"$//;s/^'"'"'//;s/'"'"'$//')
    
    # Check if this is a sensitive variable
    is_sensitive=false
    for sensitive in "${SENSITIVE_VARS[@]}"; do
        if [[ "$key" == "$sensitive" ]]; then
            is_sensitive=true
            break
        fi
    done
    
    # Add to secret if sensitive, or if explicitly requested
    if [ "$is_sensitive" = true ] || [ "$3" = "--all" ]; then
        # Convert key to lowercase with hyphens (Kubernetes convention)
        secret_key=$(echo "$key" | tr '[:upper:]' '[:lower:]' | tr '_' '-')
        SECRET_ARGS+=("--from-literal=${secret_key}=${value}")
        echo "  ✓ Adding: ${key} (as ${secret_key})"
    fi
done < "$ENV_FILE"

if [ ${#SECRET_ARGS[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No sensitive variables found in ${ENV_FILE}${NC}"
    echo "Use --all flag to include all variables"
    exit 1
fi

echo ""
echo "🔐 Creating Kubernetes Secret: ${SECRET_NAME}"
echo ""

# Create secret
kubectl create secret generic "${SECRET_NAME}" \
    --namespace="${NAMESPACE}" \
    "${SECRET_ARGS[@]}" \
    --dry-run=client -o yaml > "secret-${ENVIRONMENT}.yaml"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Secret YAML created: secret-${ENVIRONMENT}.yaml${NC}"
    echo ""
    echo "To apply the secret:"
    echo -e "  ${GREEN}kubectl apply -f secret-${ENVIRONMENT}.yaml${NC}"
    echo ""
    echo "Or create directly (without saving YAML):"
    echo -e "  ${GREEN}kubectl create secret generic ${SECRET_NAME} --namespace=${NAMESPACE} ${SECRET_ARGS[*]}${NC}"
else
    echo -e "${RED}❌ Failed to create secret${NC}"
    exit 1
fi

echo ""
echo "=========================================="
echo "✅ Secret deployment script completed!"
echo "=========================================="

