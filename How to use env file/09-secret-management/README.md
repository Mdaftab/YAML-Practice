# Secret Management Best Practices

## Structure

- `.env.example`: Template (committed to git)
- `.env`: Actual secrets (NOT committed - in .gitignore)
- `config.yaml`: References `${VAR}` placeholders

## Best Practices

1. ✅ **Never commit `.env` files**
2. ✅ **Use `.env.example` as template**
3. ✅ **Add `.env` to `.gitignore`**
4. ✅ **Use different secrets per environment**
5. ✅ **Rotate secrets regularly**
6. ✅ **Use secret management tools** (AWS Secrets Manager, HashiCorp Vault, etc.)

## Setup

```bash
# Copy example
cp .env.example .env

# Edit with real values
nano .env

# Verify .env is in .gitignore
cat .gitignore | grep .env
```

