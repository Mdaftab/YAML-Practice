#!/bin/bash
# Process YAML template with environment-specific .env file
# Usage: ./process.sh [environment]
# Example: ./process.sh development

ENV="${1:-development}"
TEMPLATE_FILE="config.yaml.template"
ENV_FILE=".env.${ENV}"
OUTPUT_FILE="config.${ENV}.yaml"

echo "=========================================="
echo "Processing ${ENV} environment"
echo "=========================================="

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Error: $ENV_FILE not found!"
    echo "Available environments:"
    ls -1 .env.* 2>/dev/null | sed 's/\.env\.//' || echo "  (none found)"
    exit 1
fi

# Load environment variables
export $(cat "$ENV_FILE" | grep -v '^#' | xargs)

# Process template
if command -v envsubst &> /dev/null; then
    envsubst < "$TEMPLATE_FILE" > "$OUTPUT_FILE"
    echo "✅ Processed: $OUTPUT_FILE"
    echo ""
    echo "Sample values:"
    echo "  DB_HOST: ${DB_HOST}"
    echo "  API_BASE_URL: ${API_BASE_URL}"
    echo "  LOG_LEVEL: ${LOG_LEVEL}"
else
    echo "❌ envsubst not found. Install with: brew install gettext"
    exit 1
fi

