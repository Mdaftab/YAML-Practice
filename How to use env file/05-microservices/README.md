# Microservices with Environment Variables

This example shows how each microservice can have its own configuration with environment variables.

## Structure

```
05-microservices/
├── auth-service/
│   ├── config.yaml
│   └── .env
├── payment-service/
│   ├── config.yaml
│   └── .env
└── README.md
```

## How It Works

Each microservice:
- Has its own `config.yaml` with service-specific variables
- Has its own `.env` file with service-specific values
- Can be deployed independently
- Can be scaled independently

## Usage

### Auth Service:
```bash
cd auth-service
export $(cat .env | grep -v '^#' | xargs)
envsubst < config.yaml > config-processed.yaml
# Use config-processed.yaml in auth service
```

### Payment Service:
```bash
cd payment-service
export $(cat .env | grep -v '^#' | xargs)
envsubst < config.yaml > config-processed.yaml
# Use config-processed.yaml in payment service
```

## Benefits

- ✅ Service isolation
- ✅ Independent configuration
- ✅ Easy to scale services
- ✅ Different secrets per service
- ✅ Service-specific feature flags

## Common Patterns

1. **Service-specific databases**
2. **Different API keys per service**
3. **Service discovery URLs**
4. **Independent logging levels**

