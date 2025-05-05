# Deployment Instructions

## Prerequisites
- AWS CLI, Terraform, Docker, Docker Compose, kubectl installed
- AWS credentials set up
- SSH key pair created and uploaded to AWS

---

## 1. Terraform Infrastructure Setup

1. Navigate to the terraform folder:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```

2. Get outputs:
    - Bastion public IP
    - App private IP
    - ECR repository URL

---

## 2. CI/CD Pipeline

- In GitHub, set the following secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `BASTION_IP` (if using SSH)
  - `BASTION_SSH_KEY` (if using SSH)
  - `APP_PRIVATE_IP`

- Push to the main branch → GitHub Actions will:
  - Build Docker image
  - Push to AWS ECR
  - Deploy to EC2 (via SSM or CodeDeploy as configured)

---

## 3. Kubernetes Deployment (optional)

1. Apply YAMLs:
    ```bash
    kubectl apply -f k8s/deployment.yaml
    kubectl apply -f k8s/service.yaml
    ```

---

## 4. Monitoring & Alerting (Prometheus + Grafana)

1. Navigate to the monitoring folder:
    ```bash
    cd monitoring
    ```

2. Start monitoring stack:
    ```bash
    docker-compose up -d
    ```

3. Access services:
    - Prometheus → http://<EC2 IP>:9090
    - Grafana → http://<EC2 IP>:3000 (default login: admin / admin)

4. Grafana setup:
    - Add Prometheus as a data source: `http://prometheus:9090`
    - Import dashboard:
      - Use dashboard ID `1860` → Node Exporter Full
    - Alerts:
      - Preconfigured for high CPU (>70%) in `alert.rules.yml`

---

## 5. Service Monitoring Script

1. Make script executable:
    ```bash
    chmod +x script.sh
    ```

2. Run the script:
    ```bash
    ./script.sh
    ```

---

## Notes

- Ensure EC2 IAM role has:
  - `AmazonEC2ContainerRegistryReadOnly`
  - `AmazonSSMManagedInstanceCore` (if using SSM)

- Update AMI IDs and regions in Terraform as needed.

- For Grafana alert channels, configure email, Slack, or webhook inside the Grafana UI.

