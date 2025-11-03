#!/bin/bash
# ============================================
# Deploy Secrets Using Kustomize
# ============================================
# This demonstrates using Kustomize to manage secrets per environment

ENVIRONMENT="${1:-development}"

echo "=========================================="
echo "Deploying with Kustomize: ${ENVIRONMENT}"
echo "=========================================="
echo ""

# Create kustomization.yaml if it doesn't exist
if [ ! -f "kustomization.yaml" ]; then
    cat > kustomization.yaml <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: ${ENVIRONMENT}

resources:
  - deployment.yaml

secretGenerator:
  - name: myapp-${ENVIRONMENT}-secrets
    namespace: ${ENVIRONMENT}
    envs:
      - .env.${ENVIRONMENT}

configMapGenerator:
  - name: myapp-${ENVIRONMENT}-config
    namespace: ${ENVIRONMENT}
    envs:
      - .env.${ENVIRONMENT}
EOF
    echo "✅ Created kustomization.yaml"
fi

# Build with kustomize
echo "Building with kustomize..."
kubectl kustomize . > "kustomized-${ENVIRONMENT}.yaml"

if [ $? -eq 0 ]; then
    echo "✅ Generated: kustomized-${ENVIRONMENT}.yaml"
    echo ""
    echo "To apply:"
    echo "  kubectl apply -k ."
    echo ""
    echo "Or apply the generated file:"
    echo "  kubectl apply -f kustomized-${ENVIRONMENT}.yaml"
else
    echo "❌ Kustomize build failed"
    exit 1
fi

