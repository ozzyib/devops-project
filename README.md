# DevOps Project

A simple Flask application with Docker containerization and Terraform infrastructure as code.

## Project Structure

```
├── app.py                    # Flask web application
├── Dockerfile               # Docker container configuration
├── main.tf                  # Terraform main configuration
├── variables.tf             # Terraform variables
├── providers.tf             # Terraform providers
├── backend.tf               # Terraform backend configuration
├── .github/
│   └── workflows/
│       └── ci.yaml          # GitHub Actions CI/CD pipeline
└── README.md                # This file
```

## Flask Application

Simple Flask app that returns the current time:
- **Endpoint**: `GET /`
- **Port**: 8080
- **Response**: Current timestamp

## Docker

Build and run the application:

```bash
# Build the Docker image
docker build -t devops-flask-app .

# Run the container
docker run -p 8080:8080 devops-flask-app
```

Visit `http://localhost:8080` to see the application.

## Terraform Infrastructure

Deploy infrastructure using Terraform:

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the changes
terraform apply
```

## CI/CD Pipeline

GitHub Actions workflow automatically:
- Builds and tests the application
- Creates Docker images
- Runs security scans
- Deploys infrastructure (if configured)

## Getting Started

1. Clone the repository
2. Install dependencies
3. Run locally or build with Docker
4. Deploy infrastructure with Terraform

## Requirements

- Docker
- Terraform
- Python 3.9+
- Flask

## License

MIT License