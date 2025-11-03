# YAML Practice Repository

<div align="center">

![YAML](https://img.shields.io/badge/YAML-1.2.2-blue?style=for-the-badge&logo=yaml)
![License](https://img.shields.io/badge/License-GPL--3.0-green?style=for-the-badge)
![DevOps](https://img.shields.io/badge/DevOps-Practice-orange?style=for-the-badge)

**A comprehensive collection of YAML examples and best practices for DevOps, Cloud Infrastructure, and Configuration Management**

[Getting Started](#-getting-started) • [Examples](#-examples) • [Use Cases](#-use-cases) • [DevOps Skills](#-devops-skills-demonstrated)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Repository Structure](#-repository-structure)
- [Getting Started](#-getting-started)
- [Examples](#-examples)
- [Environment Variables with YAML](#-environment-variables-with-yaml)
- [Use Cases](#-use-cases)
- [DevOps Skills Demonstrated](#-devops-skills-demonstrated)
- [Learning Path](#-learning-path)
- [Key Concepts](#-key-yaml-concepts-covered)
- [Best Practices](#-best-practices)
- [Tools & Resources](#-tools--resources)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

This repository is a comprehensive learning resource for YAML (YAML Ain't Markup Language), featuring practical examples across multiple DevOps domains including:

- **Container Orchestration** (Docker Compose, Kubernetes)
- **CI/CD Pipelines** (GitHub Actions, GitLab CI)
- **Infrastructure as Code** (Ansible, Terraform)
- **Configuration Management** (Multi-environment deployments)
- **Secret Management** (Security best practices)
- **Microservices Architecture**
- **Cloud-Native Applications**

All examples include detailed comments, real-world use cases, and follow industry best practices.

---

## 📁 Repository Structure

```
YAML-Practice/
├── 01-basic-syntax.yaml              # Fundamental YAML syntax
├── 02-configuration-file.yaml        # Application configuration
├── 03-api-specification.yaml          # OpenAPI/Swagger format
├── 04-docker-compose.yaml            # Multi-container orchestration
├── 05-ci-cd-pipeline.yaml            # GitHub Actions workflow
├── 06-kubernetes-deployment.yaml     # K8s resources
├── 07-data-serialization.yaml        # Complex data structures
├── 08-multi-document.yaml            # Multi-document YAML
├── 09-environment-variables.yaml    # Env var patterns
│
├── How to use env file/              # Comprehensive env var examples
│   ├── 01-multi-environment/        # Dev/Staging/Prod configs
│   ├── 02-docker-compose/           # Docker with env vars
│   ├── 03-kubernetes/                # K8s ConfigMaps & Secrets
│   │   ├── examples/
│   │   │   ├── simple/               # Basic usage
│   │   │   └── complex/              # Advanced patterns
│   │   ├── environments/             # Multi-env deployments
│   │   └── secret-management/       # Secret deployment scripts
│   ├── 04-ci-cd-pipelines/          # CI/CD with env vars
│   ├── 05-microservices/            # Service-specific configs
│   ├── 06-infrastructure-as-code/   # Ansible, Terraform
│   ├── 07-application-config/        # App config loading
│   ├── 08-feature-flags/            # Feature management
│   ├── 09-secret-management/        # Security practices
│   ├── 10-dynamic-config/            # Runtime configuration
│   ├── 11-multi-cloud/              # AWS/Azure/GCP
│   └── 12-local-development/        # Local dev setup
│
├── test_env_yaml.py                  # Python test script
├── test_env_simple.sh                # Shell test script
├── README.md                          # This file
└── LICENSE                            # GPL-3.0 License
```

---

## 🚀 Getting Started

### Prerequisites

- Basic understanding of YAML syntax
- Familiarity with DevOps concepts (recommended)
- Text editor (VS Code recommended)
- Optional: Docker, Kubernetes, CI/CD tools for hands-on practice

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd YAML-Practice
   ```

2. **Start with basics:**
   ```bash
   # Read the basic syntax file
   cat 01-basic-syntax.yaml
   ```

3. **Try environment variables:**
   ```bash
   # Navigate to environment examples
   cd "How to use env file/01-multi-environment"
   
   # Create .env file
   cp .env.development .env
   
   # Process template
   ./process.sh development
   ```

4. **Test with Python:**
   ```bash
   # Install dependencies
   pip install pyyaml python-dotenv
   
   # Run test script
   python3 test_env_yaml.py
   ```

---

## 📚 Examples

### Core YAML Files

#### 1. `01-basic-syntax.yaml`
**Fundamental YAML syntax patterns**
- Basic key-value pairs
- Data types (strings, numbers, booleans, null)
- Lists and arrays
- Dictionaries and mappings
- Nested structures
- Multi-line strings
- Anchors and aliases
- Comments and tags

#### 2. `02-configuration-file.yaml`
**Application configuration example**
- Server configuration
- Database settings
- Cache configuration
- Logging setup
- External service integrations
- Feature flags
- Security settings

#### 3. `03-api-specification.yaml`
**API specification format (OpenAPI-like)**
- Endpoint definitions
- Request/response schemas
- Authentication requirements
- Error responses
- Rate limiting

#### 4. `04-docker-compose.yaml`
**Docker Compose multi-container setup**
- Service definitions
- Environment variables
- Volume mounts
- Networks
- Health checks
- Resource limits

#### 5. `05-ci-cd-pipeline.yaml`
**GitHub Actions workflow**
- Workflow triggers
- Job definitions
- Build and test steps
- Docker image building
- Deployment workflows
- Security scanning

#### 6. `06-kubernetes-deployment.yaml`
**Kubernetes resource definitions**
- Deployments
- Services
- ConfigMaps
- Secrets
- Ingress rules
- HorizontalPodAutoscaler
- Health probes

#### 7. `07-data-serialization.yaml`
**Complex data structures**
- E-commerce product catalog
- User profile data
- Restaurant menu
- Project management data
- Scientific experiment data

#### 8. `08-multi-document.yaml`
**Multi-document YAML**
- Multiple documents in one file
- Environment configurations
- User roles and permissions
- Feature flags
- Monitoring configuration

#### 9. `09-environment-variables.yaml`
**Environment variable patterns**
- Standard `${VAR}` syntax
- Docker Compose syntax
- Kubernetes ConfigMap/Secret references
- GitHub Actions template syntax
- Tool-specific comparisons

---

## 🔧 Environment Variables with YAML

The `How to use env file/` directory contains comprehensive examples showing how to use environment variables with YAML across different tools and scenarios.

### Key Features

- **Multi-Environment Support**: Dev, Staging, Production configs
- **Docker Integration**: Compose files with env var substitution
- **Kubernetes**: ConfigMaps and Secrets management
- **CI/CD Pipelines**: Platform-specific secret handling
- **Secret Management**: Security best practices
- **Microservices**: Service-specific configurations

### Quick Example

```yaml
# config.yaml.template
database:
  host: "${DB_HOST}"
  username: "${DB_USER}"
  password: "${DB_PASSWORD}"
```

```bash
# .env
DB_HOST=localhost
DB_USER=myuser
DB_PASSWORD=mypassword

# Process
export $(cat .env | grep -v '^#' | xargs)
envsubst < config.yaml.template > config.yaml
```

See the [How to use env file/README.md](How%20to%20use%20env%20file/README.md) for detailed documentation.

---

## 💼 Use Cases

This repository demonstrates YAML usage in:

1. **Configuration Management**
   - Application settings
   - Environment-specific configs
   - Feature flags

2. **Container Orchestration**
   - Docker Compose stacks
   - Kubernetes deployments
   - Service mesh configuration

3. **CI/CD Pipelines**
   - GitHub Actions workflows
   - GitLab CI configurations
   - Deployment automation

4. **Infrastructure as Code**
   - Ansible playbooks
   - Terraform configurations
   - Cloud formation templates

5. **API Documentation**
   - OpenAPI specifications
   - Swagger definitions
   - API contract definitions

6. **Secret Management**
   - Secure credential handling
   - Multi-environment secrets
   - Secret rotation patterns

---

## 🛠️ DevOps Skills Demonstrated

This repository showcases proficiency in:

### Configuration Management
- ✅ YAML syntax and best practices
- ✅ Environment variable management
- ✅ Multi-environment deployments
- ✅ Configuration templating
- ✅ Secret management patterns

### Container Orchestration
- ✅ Docker Compose configuration
- ✅ Kubernetes manifests (Deployments, Services, ConfigMaps, Secrets)
- ✅ Health checks and resource limits
- ✅ Service discovery and networking

### CI/CD Practices
- ✅ Pipeline automation
- ✅ Environment-specific deployments
- ✅ Secret handling in CI/CD
- ✅ Automated testing and validation

### Infrastructure as Code
- ✅ Declarative configuration
- ✅ Version-controlled infrastructure
- ✅ Environment parity
- ✅ Reproducible deployments

### Security Best Practices
- ✅ Secret management
- ✅ Environment isolation
- ✅ Least privilege principles
- ✅ Secure credential handling

### Cloud-Native Patterns
- ✅ 12-factor app methodology
- ✅ Configuration externalization
- ✅ Stateless application design
- ✅ Multi-cloud deployment strategies

### Automation & Scripting
- ✅ Bash scripting for automation
- ✅ Python tools for config processing
- ✅ Template processing
- ✅ Deployment automation

---

## 📖 Learning Path

### Beginner Level
1. Start with `01-basic-syntax.yaml` - Learn fundamental YAML concepts
2. Review `02-configuration-file.yaml` - Understand configuration patterns
3. Explore `How to use env file/01-multi-environment/` - Environment variables basics

### Intermediate Level
4. Study `04-docker-compose.yaml` - Container orchestration
5. Review `06-kubernetes-deployment.yaml` - Kubernetes basics
6. Practice `How to use env file/03-kubernetes/examples/simple/` - K8s with env vars

### Advanced Level
7. Explore `05-ci-cd-pipeline.yaml` - CI/CD automation
8. Deep dive into `How to use env file/03-kubernetes/examples/complex/` - Advanced K8s
9. Study secret management patterns in `How to use env file/09-secret-management/`
10. Review multi-cloud deployment in `How to use env file/11-multi-cloud/`

### Expert Level
11. Customize examples for your use case
12. Implement in production environments
13. Contribute improvements back to the repository

---

## 🔑 Key YAML Concepts Covered

### Basic Syntax
- **Indentation**: YAML uses spaces (not tabs) for indentation
- **Key-Value Pairs**: `key: value`
- **Lists**: Use `-` for list items
- **Mappings**: Nested key-value structures
- **Comments**: Lines starting with `#`

### Advanced Features
- **Multi-line Strings**: `|` (literal) and `>` (folded)
- **Anchors & Aliases**: `&anchor` and `*alias` for reusability
- **Tags**: `!!str`, `!!int`, `!!bool` for explicit types
- **Multi-documents**: `---` separator

### Common Patterns
- **Configuration Files**: App settings, environment variables
- **API Specifications**: OpenAPI/Swagger format
- **Infrastructure as Code**: Docker Compose, Kubernetes
- **CI/CD Pipelines**: GitHub Actions, GitLab CI
- **Data Serialization**: Complex nested structures

---

## ✨ Best Practices

1. **Always use spaces for indentation** (typically 2 spaces)
2. **Use consistent quoting** (only when necessary)
3. **Add comments** for clarity and documentation
4. **Validate YAML** before using in production
5. **Use anchors** for repeated structures
6. **Keep line length reasonable** (wrap long lines)
7. **Use meaningful keys** that are self-documenting
8. **Never commit secrets** to version control
9. **Use `.env.example`** as template for environment variables
10. **Version control templates**, not processed files

---

## 🛠️ Tools & Resources

### Essential Tools
- **YAML Validator**: Online tools or VS Code extensions
- **yq**: Command-line YAML processor (like `jq` for JSON)
- **envsubst**: Environment variable substitution (part of gettext)
- **kubectl**: Kubernetes command-line tool
- **docker-compose**: Container orchestration

### Recommended Extensions
- VS Code: YAML extension
- PyCharm: Built-in YAML support
- Sublime Text: YAML syntax highlighting

### Online Resources
- [YAML Official Website](https://yaml.org/)
- [YAML Specification](https://yaml.org/spec/1.2.2/)
- [Learn YAML in Y Minutes](https://learnxinyminutes.com/docs/yaml/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

---

## 🤝 Contributing

Contributions are welcome! This repository is a learning resource, and improvements benefit everyone.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow existing code style and formatting
- Add comments to explain complex configurations
- Update README.md if adding new examples
- Test your examples before submitting
- Ensure all YAML files are valid

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0** (GPL-3.0).

### What this means:

- ✅ **Free to use**: You can use this project for any purpose
- ✅ **Open source**: Source code is available
- ✅ **Modify**: You can modify the code
- ✅ **Distribute**: You can distribute copies
- ✅ **Commercial use**: Allowed
- ⚠️ **License and copyright notice**: Must be included
- ⚠️ **State changes**: Must be documented
- ⚠️ **Disclose source**: Source code must be made available
- ⚠️ **Same license**: Modified files must use the same license

See [LICENSE](LICENSE) file for full license text.

---

## 🎓 For DevOps Engineers

This repository serves as:

- **Portfolio Project**: Demonstrates real-world DevOps skills
- **Learning Resource**: Comprehensive examples for self-study
- **Reference Guide**: Quick lookup for YAML patterns
- **Best Practices**: Industry-standard configurations
- **Interview Preparation**: Common YAML patterns in DevOps roles

### Skills Highlighted

| Skill | Examples |
|-------|----------|
| **Configuration Management** | Multi-env configs, templating, validation |
| **Container Orchestration** | Docker Compose, Kubernetes manifests |
| **CI/CD** | GitHub Actions, deployment automation |
| **Infrastructure as Code** | Declarative configs, version control |
| **Security** | Secret management, least privilege |
| **Automation** | Scripting, template processing |
| **Cloud-Native** | 12-factor app, multi-cloud |

---

## 📞 Support

If you have questions or need help:

1. Check the examples and README files
2. Review inline comments in YAML files
3. Explore the `How to use env file/` directory for detailed examples
4. Open an issue on GitHub for bugs or feature requests

---

## ⭐ Star History

If you find this repository helpful, please consider giving it a star! ⭐

---

<div align="center">

**Built with ❤️ for the DevOps community**

[⬆ Back to Top](#yaml-practice-repository)

---


</div>
