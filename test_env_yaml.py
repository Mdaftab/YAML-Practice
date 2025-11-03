#!/usr/bin/env python3
"""
Test script to verify environment variables in YAML files
This script loads .env file and processes YAML with ${VAR} placeholders
"""

import os
import re
from pathlib import Path

# Try to import yaml
try:
    import yaml
    YAML_AVAILABLE = True
except ImportError:
    YAML_AVAILABLE = False
    print("⚠️  pyyaml not installed. Install with: pip3 install --user pyyaml")
    print("   Will show variable substitution without YAML parsing...\n")

# Try to load python-dotenv if available
try:
    from dotenv import load_dotenv
    DOTENV_AVAILABLE = True
except ImportError:
    DOTENV_AVAILABLE = False
    print("⚠️  python-dotenv not installed. Install with: pip3 install --user python-dotenv")
    print("   Loading environment variables manually...\n")

def load_env_file():
    """Load environment variables from .env file"""
    env_path = Path('.env')
    
    if DOTENV_AVAILABLE:
        load_dotenv()
        return True
    else:
        # Manual loading
        if env_path.exists():
            with open(env_path, 'r') as f:
                for line in f:
                    line = line.strip()
                    # Skip comments and empty lines
                    if line and not line.startswith('#') and '=' in line:
                        key, value = line.split('=', 1)
                        os.environ[key.strip()] = value.strip()
            return True
    return False

def replace_env_vars(text):
    """Replace ${VAR} or ${VAR:-default} with actual environment values"""
    def replace(match):
        var_name = match.group(1)
        default = match.group(2) if match.lastindex > 1 else None
        
        # Get value from environment
        value = os.environ.get(var_name)
        
        # Use default if value not found
        if value is None and default is not None:
            value = default
        elif value is None:
            value = ''  # Empty string if not found and no default
        
        return str(value)
    
    # Pattern matches ${VAR} or ${VAR:-default}
    pattern = r'\$\{([^}:]+)(?::([^}]+))?\}'
    return re.sub(pattern, replace, text)

def print_section(title):
    """Print a formatted section header"""
    print("\n" + "=" * 70)
    print(f"  {title}")
    print("=" * 70)

def main():
    print_section("Environment Variable Test for YAML")
    
    # Load .env file
    print("\n📁 Loading .env file...")
    if load_env_file():
        print("✅ .env file loaded successfully")
    else:
        print("❌ .env file not found or couldn't be loaded")
        return
    
    # Show environment variables
    print_section("Environment Variables from .env")
    env_vars = ['DB_HOST', 'DB_PORT', 'DB_USER', 'DB_PASSWORD', 
                'DB_NAME', 'STRIPE_API_KEY', 'JWT_SECRET']
    
    for var in env_vars:
        value = os.environ.get(var)
        if value:
            # Mask passwords and secrets for security
            display_value = value
            if 'PASSWORD' in var or 'SECRET' in var or 'KEY' in var:
                display_value = '*' * len(value) if value else 'NOT SET'
            print(f"  {var:20s} = {display_value}")
        else:
            print(f"  {var:20s} = ❌ NOT SET")
    
    # Process YAML file
    yaml_file = '02-configuration-file.yaml'
    print_section(f"Processing YAML File: {yaml_file}")
    
    if not Path(yaml_file).exists():
        print(f"❌ File {yaml_file} not found!")
        return
    
    # Read YAML file
    print(f"📖 Reading {yaml_file}...")
    with open(yaml_file, 'r') as f:
        yaml_content = f.read()
    
    # Show original placeholders
    print("\n🔍 Found environment variable references:")
    env_refs = re.findall(r'\$\{([^}]+)\}', yaml_content)
    for ref in set(env_refs):
        var_name = ref.split(':-')[0]  # Remove default value if present
        value = os.environ.get(var_name, 'NOT SET')
        if 'PASSWORD' in var_name or 'SECRET' in var_name or 'KEY' in var_name:
            display_value = '*' * len(value) if value != 'NOT SET' else 'NOT SET'
        else:
            display_value = value
        print(f"  ${var_name} → {display_value}")
    
    # Replace environment variables
    print("\n🔄 Replacing environment variables...")
    processed_content = replace_env_vars(yaml_content)
    
    # Parse YAML
    if YAML_AVAILABLE:
        try:
            config = yaml.safe_load(processed_content)
            print("✅ YAML parsed successfully")
        except yaml.YAMLError as e:
            print(f"❌ Error parsing YAML: {e}")
            return
    else:
        print("⚠️  Skipping YAML parsing (pyyaml not available)")
        print("   Showing processed content with substitutions:")
        print("\n" + "-" * 70)
        # Show just the parts with substitutions
        lines = processed_content.split('\n')
        for i, line in enumerate(lines, 1):
            if '${' not in line and any(var in line for var in ['DB_HOST', 'DB_USER', 'DB_PASSWORD', 'username', 'password']):
                print(f"{i:4d}: {line}")
        print("-" * 70 + "\n")
        return
    
    # Show database configuration
    print_section("Database Configuration (from YAML)")
    if 'database' in config and 'primary' in config['database']:
        db = config['database']['primary']
        print(f"  Type:        {db.get('type', 'N/A')}")
        print(f"  Host:        {db.get('host', 'N/A')}")
        print(f"  Port:        {db.get('port', 'N/A')}")
        print(f"  Name:        {db.get('name', 'N/A')}")
        print(f"  Username:    {db.get('username', 'N/A')}")
        password = db.get('password', '')
        print(f"  Password:    {'*' * len(password) if password else 'NOT SET'}")
        
        if 'pool' in db:
            print(f"\n  Connection Pool:")
            print(f"    Min:       {db['pool'].get('min', 'N/A')}")
            print(f"    Max:       {db['pool'].get('max', 'N/A')}")
    
    # Show other configurations with env vars
    print_section("Other Configurations with Environment Variables")
    
    # Check security section
    if 'security' in config and 'jwt' in config['security']:
        jwt_secret = config['security']['jwt'].get('secret', '')
        if jwt_secret:
            print(f"  JWT Secret:  {'*' * len(jwt_secret)}")
        else:
            print(f"  JWT Secret:  ❌ NOT SET")
    
    # Check services section
    if 'services' in config:
        services = config['services']
        if 'payment' in services:
            api_key = services['payment'].get('api_key', '')
            if api_key:
                print(f"  Stripe API Key: {'*' * len(api_key)}")
            else:
                print(f"  Stripe API Key: ❌ NOT SET")
    
    # Show connection string example
    print_section("Example: Constructed Connection String")
    if 'database' in config and 'primary' in config['database']:
        db = config['database']['primary']
        username = db.get('username', '')
        password = db.get('password', '')
        host = db.get('host', '')
        port = db.get('port', '')
        name = db.get('name', '')
        
        if all([username, password, host, port, name]):
            conn_string = f"postgresql://{username}:{'*' * len(password)}@{host}:{port}/{name}"
            print(f"  {conn_string}")
        else:
            print("  ⚠️  Cannot construct - missing required values")
    
    # Summary
    print_section("Summary")
    total_vars = len(set(env_refs))
    set_vars = sum(1 for ref in set(env_refs) 
                   if os.environ.get(ref.split(':-')[0]))
    print(f"  Total variables in YAML: {total_vars}")
    print(f"  Variables set in .env: {set_vars}")
    print(f"  Variables missing: {total_vars - set_vars}")
    
    if set_vars == total_vars:
        print("\n  ✅ All environment variables are set!")
    else:
        print(f"\n  ⚠️  {total_vars - set_vars} environment variable(s) are missing")
    
    print("\n" + "=" * 70)
    print("  Test completed!")
    print("=" * 70 + "\n")

if __name__ == '__main__':
    main()

