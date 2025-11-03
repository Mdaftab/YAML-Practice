#!/bin/bash
# ============================================
# Complex Example: Create Multiple ConfigMaps and Secrets from .env
# ============================================

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: $ENV_FILE not found!"
    exit 1
fi

echo "📦 Creating complex Kubernetes resources from $ENV_FILE"
echo ""

# Load environment variables
export $(cat "$ENV_FILE" | grep -v '^#' | xargs)

# ============================================
# Create Main Application ConfigMap
# ============================================
echo "Creating app-config ConfigMap..."
kubectl create configmap app-config \
  --from-literal=node-env="${NODE_ENV}" \
  --from-literal=log-level="${LOG_LEVEL}" \
  --from-literal=api-timeout="${API_TIMEOUT}" \
  --from-literal=max-connections="${MAX_CONNECTIONS}" \
  --from-literal=cache-ttl="${CACHE_TTL}" \
  --dry-run=client -o yaml > configmap-app.yaml

echo "✅ Created: configmap-app.yaml"

# ============================================
# Create Feature Flags ConfigMap
# ============================================
echo "Creating feature-flags ConfigMap..."
kubectl create configmap feature-flags \
  --from-literal=enable-payments="${ENABLE_PAYMENTS}" \
  --from-literal=enable-analytics="${ENABLE_ANALYTICS}" \
  --from-literal=enable-beta-features="${ENABLE_BETA_FEATURES}" \
  --from-literal=maintenance-mode="${MAINTENANCE_MODE}" \
  --dry-run=client -o yaml > configmap-features.yaml

echo "✅ Created: configmap-features.yaml"

# ============================================
# Create Database Secrets
# ============================================
echo "Creating db-secrets Secret..."
kubectl create secret generic db-secrets \
  --from-literal=database-url="${DATABASE_URL}" \
  --from-literal=db-host="${DB_HOST}" \
  --from-literal=db-user="${DB_USER}" \
  --from-literal=db-password="${DB_PASSWORD}" \
  --from-literal=pool-size="${DB_POOL_SIZE}" \
  --dry-run=client -o yaml > secret-db.yaml

echo "✅ Created: secret-db.yaml"

# ============================================
# Create API Secrets
# ============================================
echo "Creating api-secrets Secret..."
kubectl create secret generic api-secrets \
  --from-literal=stripe-api-key="${STRIPE_API_KEY}" \
  --from-literal=stripe-webhook-secret="${STRIPE_WEBHOOK_SECRET}" \
  --from-literal=jwt-secret="${JWT_SECRET}" \
  --from-literal=api-key="${API_KEY}" \
  --dry-run=client -o yaml > secret-api.yaml

echo "✅ Created: secret-api.yaml"

# ============================================
# Create Logging Secrets
# ============================================
echo "Creating logging-secrets Secret..."
kubectl create secret generic logging-secrets \
  --from-literal=endpoint="${LOG_ENDPOINT}" \
  --from-literal=api-key="${LOGGING_API_KEY}" \
  --dry-run=client -o yaml > secret-logging.yaml

echo "✅ Created: secret-logging.yaml"

echo ""
echo "=========================================="
echo "✅ All resources created!"
echo "=========================================="
echo ""
echo "To apply all resources:"
echo "  kubectl apply -f configmap-app.yaml"
echo "  kubectl apply -f configmap-features.yaml"
echo "  kubectl apply -f secret-db.yaml"
echo "  kubectl apply -f secret-api.yaml"
echo "  kubectl apply -f secret-logging.yaml"
echo "  kubectl apply -f deployment.yaml"
echo ""
echo "Or apply all at once:"
echo "  kubectl apply -f ."

