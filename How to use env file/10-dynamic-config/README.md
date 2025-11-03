# Dynamic Configuration

Configuration that can be updated at runtime without code changes.

## Usage

Change environment variables and restart the application:

```bash
# Enable maintenance mode
export MAINTENANCE_MODE=true
# Restart app - config.yaml will reflect new value

# Increase rate limit
export API_RATE_LIMIT=500
# Restart app
```

## Benefits

- ✅ Update configuration without redeploying
- ✅ Quick response to incidents (maintenance mode)
- ✅ A/B testing with different settings
- ✅ Gradual feature rollouts

