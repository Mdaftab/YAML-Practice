#!/bin/bash
# Create Kubernetes ConfigMap and Secrets from .env file
# Usage: ./create-resources.sh [.env-file]

ENV_FILE="${1:-.env}"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: $ENV_FILE not found!"
    exit 1
fi

echo "📦 Creating Kubernetes resources from $ENV_FILE"
echo ""

# Create ConfigMap from non-sensitive variables
echo "Creating ConfigMap..."
kubectl create configmap app-config \
  --from-env-file=<(grep -E "^(NODE_ENV|LOG_LEVEL|API_BASE_URL)=" "$ENV_FILE") \
  --dry-run=client -o yaml > configmap.yaml 2>/dev/null || \
kubectl create configmap app-config \
  --from-literal=node-env=$(grep NODE_ENV "$ENV_FILE" | cut -d'=' -f2) \
  --from-literal=log-level=$(grep LOG_LEVEL "$ENV_FILE" | cut -d'=' -f2) \
  --from-literal=api-base-url=$(grep API_BASE_URL "$ENV_FILE" | cut -d'=' -f2) \
  --dry-run=client -o yaml > configmap.yaml

echo "✅ ConfigMap created: configmap.yaml"

# Create Secret from sensitive variables
echo "Creating Secret..."
kubectl create secret generic app-secrets \
  --from-env-file=<(grep -E "^(DATABASE_URL|API_KEY|JWT_SECRET)=" "$ENV_FILE") \
  --dry-run=client -o yaml > secret.yaml 2>/dev/null || \
kubectl create secret generic app-secrets \
  --from-literal=database-url=$(grep DATABASE_URL "$ENV_FILE" | cut -d'=' -f2) \
  --from-literal=api-key=$(grep API_KEY "$ENV_FILE" | cut -d'=' -f2) \
  --from-literal=jwt-secret=$(grep JWT_SECRET "$ENV_FILE" | cut -d'=' -f2) \
  --dry-run=client -o yaml > secret.yaml

echo "✅ Secret created: secret.yaml"
echo ""
echo "To apply:"
echo "  kubectl apply -f configmap.yaml"
echo "  kubectl apply -f secret.yaml"
echo "  kubectl apply -f deployment.yaml"

