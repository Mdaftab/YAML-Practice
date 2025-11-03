# Docker Compose with Environment Variables

This example shows how to use environment variables in Docker Compose for flexible container configuration.

## Structure

```
02-docker-compose/
├── docker-compose.yaml    # Compose file with ${VAR} references
├── .env                   # Environment variables
└── README.md              # This file
```

## How It Works

Docker Compose automatically substitutes `${VAR}` and `$VAR` syntax with environment variables:
- From `.env` file (if using `env_file:`)
- From shell environment
- From command line with `-e` flag

## Usage

### Basic Usage (automatically loads .env):
```bash
docker-compose up -d
```

### Specify Custom .env File:
```bash
docker-compose --env-file .env.production up -d
```

### Override Variables:
```bash
# Override specific variables
API_KEY=prod_key docker-compose up -d

# Or use -e flag
docker-compose -e API_KEY=prod_key up -d
```

### Use Different Environments:
```bash
# Development
docker-compose --env-file .env.development up -d

# Production
docker-compose --env-file .env.production up -d
```

## Environment Variables in docker-compose.yaml

1. **Direct Substitution**:
   ```yaml
   container_name: ${APP_NAME}_web
   ports:
     - "${WEB_PORT:-80}:80"  # Default value if not set
   ```

2. **In environment section**:
   ```yaml
   environment:
     - NODE_ENV=${NODE_ENV}
     - API_KEY=${API_KEY}
   ```

3. **From .env file**:
   ```yaml
   env_file:
     - .env
     # Or specific file
     - .env.production
   ```

## Benefits

- ✅ No hardcoded values in docker-compose.yaml
- ✅ Easy to switch between environments
- ✅ Secrets not in version control
- ✅ One compose file for all environments

## Example Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f api

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## Security Note

Never commit `.env` files with real secrets to version control. Use `.env.example` as a template:

```bash
# .env.example (committed)
APP_NAME=myapp
DB_USER=your_user
DB_PASSWORD=your_password

# .env (NOT committed - in .gitignore)
APP_NAME=myapp
DB_USER=real_user
DB_PASSWORD=real_secure_password
```

