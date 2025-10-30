# DevOps Project 🚀

A complete DevOps demonstration project featuring a Python Flask application with full CI/CD pipeline, Infrastructure as Code, and GitOps deployment using ArgoCD. This project showcases modern DevOps practices with automated testing, containerization, infrastructure provisioning, and continuous deployment.

[![CI/CD Pipeline](https://github.com/ozzyib/devops-project/actions/workflows/ci.yaml/badge.svg)](https://github.com/ozzyib/devops-project/actions)
[![Docker Image](https://img.shields.io/badge/docker-YOUR__USERNAME%2Fdevops--project-blue)](https://hub.docker.com/r/YOUR_USERNAME/devops-project)

## 🏗️ Architecture Overview

This project implements a complete DevOps stack:

- **Application**: Python Flask web service
- **Containerization**: Docker with multi-stage builds
- **Infrastructure**: Terraform with Minikube for local Kubernetes
- **GitOps**: ArgoCD for continuous deployment
- **CI/CD**: GitHub Actions with automated testing and deployment
- **Monitoring**: Built-in health checks and readiness probes

## 📁 Project Structure

```
devops-project/
├── .github/workflows/          # CI/CD Pipelines
│   └── ci.yaml                 # GitHub Actions workflow
├── src/                        # 🐍 Application Source Code
│   ├── app.py                  # Flask web application
│   └── Dockerfile              # Container definition
├── infrastructure/             # 🏗️ Infrastructure as Code
│   ├── main.tf                 # Main Terraform configuration
│   ├── providers.tf            # Provider configurations
│   ├── variables.tf            # Input variables
│   ├── argocd.tf              # ArgoCD deployment
│   └── backend.tf             # State backend configuration
├── k8s/                       # ☸️ Kubernetes Configurations
│   ├── helm/devops-app/       # Helm chart for application
│   │   ├── Chart.yaml         # Helm chart metadata
│   │   ├── values.yaml        # Configuration values
│   │   └── templates/         # Kubernetes manifests
│   └── argocd/               # ArgoCD Application definitions
│       └── application.yaml   # ArgoCD app configuration
├── docs/                      # 📚 Documentation
├── scripts/                   # 🔧 Utility scripts
└── README.md                  # This file
```

## 🚀 Quick Start

### Prerequisites

- **Docker** - For containerization
- **Terraform** (v1.5+) - For infrastructure provisioning
- **kubectl** - For Kubernetes cluster interaction
- **Minikube** - For local Kubernetes cluster
- **Python 3.9+** - For local development
- **Docker Hub Account** - For pushing container images

### Configuration Setup

Before getting started, you'll need to configure your Docker Hub credentials for the CI/CD pipeline:

1. **Fork this repository** to your GitHub account
2. **Update Docker image references**:
   - Replace `YOUR_USERNAME` with your Docker Hub username in:
     - `.github/workflows/ci.yaml`
     - `k8s/helm/devops-app/values.yaml`
     - Badge URLs in this README
3. **Add GitHub Secrets** for Docker Hub integration:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub access token

### 1. Clone & Setup

```bash
git clone https://github.com/ozzyib/devops-project.git
cd devops-project

# Install Python dependencies (for local development)
pip install flask pytest
```

### 2. Local Development

```bash
# Run the Flask app locally
cd src/
python app.py

# Test the application
curl http://localhost:8080
curl http://localhost:8080/health
```

### 3. Infrastructure Deployment

```bash
# Navigate to infrastructure directory
cd infrastructure/

# Initialize Terraform
terraform init

# Create local Kubernetes cluster and deploy ArgoCD
terraform plan
terraform apply

# Verify cluster is running
kubectl get nodes
kubectl get pods -n argocd
```

### 4. Application Deployment via GitOps

The application automatically deploys through ArgoCD once the infrastructure is ready:

```bash
# Check ArgoCD application status
kubectl get applications -n argocd

# Port forward to ArgoCD UI (optional)
kubectl port-forward service/argocd-server -n argocd 8081:443

# Access ArgoCD UI at https://localhost:8081
# Username: admin
# Password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

> **🔒 Security Note**: This password is for local development only. Each deployment generates a unique password that's only accessible on your local machine (localhost). For production deployments, always change the default password and implement proper RBAC.
```

## 🔄 CI/CD Pipeline

The GitHub Actions pipeline automatically:

### 🧪 Test Stage
- ✅ Runs Flask application tests
- ✅ Validates Python code quality
- ✅ Ensures application health endpoints respond correctly

### 🐳 Build & Push Stage  
- ✅ Builds Docker image with commit SHA tag
- ✅ Tests containerized application
- ✅ Pushes to Docker Hub (`YOUR_USERNAME/devops-project`)
- ✅ Updates Helm chart values with new image tag

### 🏗️ Infrastructure Validation
- ✅ Validates Terraform configuration formatting
- ✅ Runs `terraform plan` to verify infrastructure changes
- ✅ Ensures infrastructure code quality

### 🔄 GitOps Deployment
- ✅ ArgoCD automatically detects Helm chart changes
- ✅ Deploys new application version to Kubernetes
- ✅ Provides rollback capabilities and deployment history

## 🌐 Application Endpoints

| Endpoint | Method | Description |
|----------|---------|-------------|
| `/` | GET | Returns current timestamp with emoji |
| `/health` | GET | Health check endpoint for probes |
| `/time` | GET | Current server time in JSON format |

## 🛠️ Technology Stack

### Application Layer
- **Flask** - Lightweight Python web framework
- **Python 3.9** - Runtime environment
- **Gunicorn** - Production WSGI server

### Container & Orchestration
- **Docker** - Application containerization
- **Kubernetes** - Container orchestration
- **Minikube** - Local Kubernetes development
- **Helm** - Kubernetes package manager

### Infrastructure & GitOps
- **Terraform** - Infrastructure as Code
- **ArgoCD** - GitOps continuous deployment
- **GitHub Actions** - CI/CD automation

### Monitoring & Observability
- **Kubernetes Probes** - Health checking
- **Docker Health Checks** - Container monitoring

## 🔧 Development Workflow

1. **Code Changes** → Push to GitHub
2. **CI Pipeline** → Automated testing and Docker build
3. **Image Push** → New tagged image to Docker Hub
4. **Helm Update** → Automatic values.yaml update with new image tag
5. **ArgoCD Sync** → Detects changes and deploys to Kubernetes
6. **Health Checks** → Verifies deployment success

## 📊 Monitoring & Operations

### Health Checks
```bash
# Check application health
kubectl get pods
kubectl describe pod <pod-name>

# View application logs
kubectl logs -l app.kubernetes.io/name=devops-app

# Check ArgoCD sync status
kubectl get applications -n argocd
```

### Troubleshooting
```bash
# Debug infrastructure
cd infrastructure/
terraform plan
terraform refresh

# Check ArgoCD status
kubectl get pods -n argocd
kubectl logs -n argocd deployment/argocd-application-controller
```

## 🚀 Production Considerations

### 🔒 **Security (Critical)**
- **Change Default Passwords**: Update ArgoCD admin password immediately
- **RBAC**: Implement Role-Based Access Control for ArgoCD and Kubernetes
- **TLS/SSL**: Enable proper TLS certificates (not self-signed)
- **Network Policies**: Restrict pod-to-pod communication
- **Secret Management**: Use HashiCorp Vault, AWS Secrets Manager, or sealed-secrets

### 📊 **Observability & Operations**
- **Monitoring**: Add Prometheus, Grafana for metrics and alerting
- **Logging**: Implement centralized logging (ELK/EFK stack)
- **Tracing**: Add distributed tracing with Jaeger or Zipkin
- **Scaling**: Configure HPA (Horizontal Pod Autoscaler)
- **Backup**: Implement etcd backups and disaster recovery plans

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎯 Learning Outcomes

This project demonstrates:
- ✅ Complete CI/CD pipeline implementation
- ✅ Infrastructure as Code with Terraform
- ✅ GitOps deployment patterns with ArgoCD
- ✅ Kubernetes application deployment and management
- ✅ Docker containerization best practices
- ✅ Automated testing and quality assurance
- ✅ Modern DevOps toolchain integration

---

**Built with ❤️ for learning DevOps practices**