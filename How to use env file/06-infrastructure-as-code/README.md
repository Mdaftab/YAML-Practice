# Infrastructure as Code with Environment Variables

Examples for Ansible, Terraform, and other IaC tools using environment variables.

## Ansible Example

```bash
# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Run playbook
ansible-playbook ansible-playbook.yaml
```

## Terraform Example

```bash
# Create terraform.tfvars from .env
export $(cat .env | grep -v '^#' | xargs)
cat > terraform.tfvars << EOF
db_host = "$DB_HOST"
db_user = "$DB_USER"
db_password = "$DB_PASSWORD"
api_key = "$API_KEY"
EOF

# Apply
terraform plan
terraform apply
```

