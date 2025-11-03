// Node.js Application Loading Config with Environment Variables
require('dotenv').config();
const fs = require('fs');
const yaml = require('js-yaml');

// Load YAML config
const configContent = fs.readFileSync('config.yaml', 'utf8');

// Replace ${VAR} with environment variables
const processed = configContent.replace(/\$\{([^}]+)\}/g, (match, varName) => {
  const [var, defaultValue] = varName.split(':-');
  return process.env[var] || defaultValue || match;
});

// Parse YAML
const config = yaml.load(processed);

// Use config
console.log('Database URL:', config.database.url);
console.log('API Base URL:', config.api.base_url);
console.log('Log Level:', config.logging.level);

module.exports = config;

