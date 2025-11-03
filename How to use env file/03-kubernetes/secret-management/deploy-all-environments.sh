#!/bin/bash
# ============================================
# Deploy Secrets for All Environments
# ============================================
# This script deploys secrets for development, staging, and production
# from their respective .env files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_SCRIPT="${SCRIPT_DIR}/deploy-secrets.sh"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "Deploying Secrets for All Environments"
echo "=========================================="
echo ""

ENVIRONMENTS=("development" "staging" "production")

for env in "${ENVIRONMENTS[@]}"; do
    echo -e "${YELLOW}Processing: ${env}${NC}"
    echo "----------------------------------------"
    
    # Find .env file for this environment
    ENV_FILE=""
    if [ -f "${SCRIPT_DIR}/../environments/${env}/.env.${env}" ]; then
        ENV_FILE="${SCRIPT_DIR}/../environments/${env}/.env.${env}"
    elif [ -f ".env.${env}" ]; then
        ENV_FILE=".env.${env}"
    else
        echo "⚠️  .env.${env} not found, skipping..."
        echo ""
        continue
    fi
    
    # Run deploy script
    bash "${DEPLOY_SCRIPT}" "${env}" "${ENV_FILE}"
    echo ""
done

echo -e "${GREEN}✅ All environments processed!${NC}"
echo ""
echo "To apply all secrets:"
echo "  kubectl apply -f secret-development.yaml"
echo "  kubectl apply -f secret-staging.yaml"
echo "  kubectl apply -f secret-production.yaml"

