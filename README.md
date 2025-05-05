# Architecture Diagram
![Architecture Diagram](awsdiag(bastion).drawio.png)


# Deployment Instructions

## Prerequisites
- AWS CLI, Terraform, Docker, kubectl installed
- AWS credentials set up
- SSH key pair created and uploaded to AWS

## Steps
1. Terraform:
```sh
    cd terraform
    terraform init
    terraform plan
    terraform apply
```
2. CI/CD:
- Set GitHub secrets: DOCKERHUB_USERNAME, DOCKERHUB_PASSWORD, BASTION_IP, BASTION_SSH_KEY, APP_PRIVATE_IP
- Push to main branch → GitHub Actions will build, push, and deploy

3. Monitoring:
- Access Grafana dashboard at http://<bastion-ip>:3000

4. Script:
```sh
sh script.sh
```
