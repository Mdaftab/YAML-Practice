# Application Configuration Loading

This example shows how to load YAML configuration files with environment variable substitution in applications (Node.js, Python, etc.).

## Node.js Example

```javascript
// Load .env file
require('dotenv').config();

// Process YAML with env var substitution
const config = yaml.load(processedContent);
```

## Python Example

```python
from dotenv import load_dotenv
import yaml
import os
import re

load_dotenv()

# Replace ${VAR} with environment variables
content = re.sub(r'\$\{(\w+)\}', 
    lambda m: os.environ.get(m.group(1), ''), 
    yaml_content)

config = yaml.safe_load(content)
```

