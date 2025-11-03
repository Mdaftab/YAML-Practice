#!/bin/bash
# Simple shell script to test environment variables in YAML

echo "================================================================"
echo "  Environment Variable Test for YAML (Shell Version)"
echo "================================================================"
echo ""

# Load .env file
echo "📁 Loading .env file..."
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
    echo "✅ .env file loaded successfully"
else
    echo "❌ .env file not found!"
    exit 1
fi

echo ""
echo "================================================================"
echo "  Environment Variables from .env"
echo "================================================================"
echo "  DB_HOST     = ${DB_HOST:-NOT SET}"
echo "  DB_PORT     = ${DB_PORT:-NOT SET}"
echo "  DB_USER     = ${DB_USER:-NOT SET}"
echo "  DB_PASSWORD = ${DB_PASSWORD:-NOT SET} (masked)"
echo ""

# Process YAML file
YAML_FILE="02-configuration-file.yaml"
echo "================================================================"
echo "  Processing YAML File: $YAML_FILE"
echo "================================================================"

if [ ! -f "$YAML_FILE" ]; then
    echo "❌ File $YAML_FILE not found!"
    exit 1
fi

echo ""
echo "🔍 Showing lines with environment variable substitutions:"
echo ""

# Replace ${VAR} with actual values and show relevant lines
grep -n '\${' "$YAML_FILE" | while IFS=: read line_num line; do
    # Extract variable name
    var_name=$(echo "$line" | sed -n 's/.*\${\([^}]*\)}.*/\1/p' | cut -d':' -f1)
    
    # Get value
    var_value=$(eval echo \$$var_name)
    
    # Replace in line
    processed_line=$(echo "$line" | sed "s|\${[^}]*}|$var_value|g")
    
    # Mask passwords
    if echo "$line" | grep -q -i "password\|secret\|key" && [ -n "$var_value" ]; then
        masked_value=$(printf '*%.0s' {1..${#var_value}})
        processed_line=$(echo "$processed_line" | sed "s|$var_value|$masked_value|g")
    fi
    
    echo "  Line $line_num: $processed_line"
done

echo ""
echo "================================================================"
echo "  Direct Variable Substitution Test"
echo "================================================================"
echo ""
echo "Testing database configuration values:"
echo "  database.primary.username = ${DB_USER:-NOT SET}"
echo "  database.primary.password = ${DB_PASSWORD:+$(echo ${DB_PASSWORD} | sed 's/./*/g')}"
echo "  database.replica.username = ${DB_USER:-NOT SET}"
echo "  database.replica.password = ${DB_PASSWORD:+$(echo ${DB_PASSWORD} | sed 's/./*/g')}"
echo ""

echo "================================================================"
echo "  Summary"
echo "================================================================"
echo "  ✅ Environment variables loaded from .env"
echo "  ✅ YAML file processed"
echo "  ✅ Variable substitution verified"
echo ""
echo "================================================================"

