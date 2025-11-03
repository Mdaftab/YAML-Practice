#!/bin/bash
# ============================================
# Simple Example: Create ConfigMap and Secret from .env
# ============================================

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: $ENV_FILE not found!"
    exit 1
fi

echo "📦 Creating Kubernetes resources from $ENV_FILE"
echo ""

# Create ConfigMap from non-sensitive variables
echo "Creating ConfigMap..."
kubectl create configmap simple-config \
  --from-literal=environment=$(grep ENVIRONMENT "$ENV_FILE" | cut -d'=' -f2) \
  --from-literal=log-level=$(grep LOG_LEVEL "$ENV_FILE" | cut -d'=' -f2) \
  --dry-run=client -o yaml > configmap.yaml

echo "✅ ConfigMap created: configmap.yaml"

# Create Secret from sensitive variables
echo "Creating Secret..."
kubectl create secret generic simple-secret \
  --from-literal=api-key=$(grep API_KEY "$ENV_FILE" | cut -d'=' -f2) \
  --dry-run=client -o yaml > secret.yaml

echo "✅ Secret created: secret.yaml"
echo ""
echo "To apply:"
echo "  kubectl apply -f configmap.yaml"
echo "  kubectl apply -f secret.yaml"
echo "  kubectl apply -f deployment.yaml"

