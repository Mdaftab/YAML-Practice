#!/bin/bash
# ============================================
# Deploy All Environments from .env Files
# ============================================
# This script creates ConfigMaps and Secrets for all environments
# and applies the deployments

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================="
echo "Deploying All Environments"
echo "=========================================="
echo ""

ENVIRONMENTS=("development" "staging" "production")

for env in "${ENVIRONMENTS[@]}"; do
    ENV_DIR="${SCRIPT_DIR}/${env}"
    ENV_FILE="${ENV_DIR}/.env.${env}"
    
    if [ ! -f "$ENV_FILE" ]; then
        echo "⚠️  Skipping ${env}: .env.${env} not found"
        continue
    fi
    
    echo "=========================================="
    echo "Processing: ${env}"
    echo "=========================================="
    
    # Create namespace
    kubectl create namespace "${env}" --dry-run=client -o yaml | kubectl apply -f -
    
    # Load environment variables
    export $(cat "$ENV_FILE" | grep -v '^#' | xargs)
    
    # Create ConfigMap
    echo "Creating ConfigMap..."
    kubectl create configmap "myapp-${env}-config" \
        --namespace="${env}" \
        --from-literal=node-env="${NODE_ENV}" \
        --from-literal=log-level="${LOG_LEVEL}" \
        --from-literal=api-base-url="${API_BASE_URL}" \
        --dry-run=client -o yaml | kubectl apply -f -
    
    # Create Secret
    echo "Creating Secret..."
    kubectl create secret generic "myapp-${env}-secrets" \
        --namespace="${env}" \
        --from-literal=database-url="${DATABASE_URL}" \
        --from-literal=api-key="${API_KEY}" \
        --from-literal=jwt-secret="${JWT_SECRET}" \
        --dry-run=client -o yaml | kubectl apply -f -
    
    # Apply deployment
    echo "Applying deployment..."
    kubectl apply -f "${ENV_DIR}/deployment.yaml"
    
    echo "✅ ${env} deployed successfully!"
    echo ""
done

echo "=========================================="
echo "✅ All environments deployed!"
echo "=========================================="

