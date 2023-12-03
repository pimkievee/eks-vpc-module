# EKS CLUSTER WITH CUSTOM VPC

## Read! EKS: Requirements 

### VPC
- Must have a minimum of 2-4 subnets in different AZs (2 public, 2 private). VPC must be tagged.

### Subnet
- Subnets have to be tagged for ALB
  ```tags = { Name = "public" "kubernetes.io/role/elb" = "1" "kubernete.io/cluster/demo" = "owned" or "shared" }```
- VPC needs DNS hostname support.
- VPC needs DNS resolution.

---

## EKS Deployment Steps

This repository contains configurations and scripts for deploying a custom Virtual Private Cloud (VPC) with an Amazon EKS cluster, Istio service mesh, various add-ons, and integrations.

### Features

- **Amazon EKS Cluster**: Managed Kubernetes cluster for container orchestration.
- **Istio Service Mesh**: A service mesh to manage microservices communication and security.
- **IAM Roles for Service Accounts (IRSA)**: Integrates IAM roles with Kubernetes service accounts.
- **Horizontal Pod Autoscaler**: Automatically adjusts the number of Kubernetes pods.
- **OpenID Connect (OIDC)**: Authentication method allowing IAM users to access the cluster.
- **Prometheus**: Monitoring and alerting toolkit for containerized environments.
- **Grafana**: Visualization and analytics platform for monitoring metrics.
- **Helm**: Package manager for Kubernetes applications.
- **EFS CSI Driver**: Amazon Elastic File System Container Storage Interface driver.
- **CNI (Container Networking Interface)**: Network plugin to enable networking between containers.

### Prerequisites

- AWS CLI installed and configured with appropriate permissions.
- `kubectl` CLI installed for Kubernetes cluster management.
- Helm v3 installed for package management.
- Istio installation files and configurations.

### Directory Structure

- `/scripts`: Deployment scripts and automation tools.
- `/config`: Configuration files for VPC, IAM, Kubernetes manifests, etc.
- `/istio`: Istio installation and configuration files.
- `/helm-charts`: Helm chart configurations for Prometheus, Grafana, etc.

---

## Cluster IAM roles

- EKS makes API calls to other services; IAM with `AmazonEKSClusterPolicy` is attached.
- The role needs to have the principal as `eks.amazonaws.com` service to assume it.
```hcl
resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "main-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = aws_iam_role.demo.name
}


## Deployment Steps

 **Clone the Repository:**

   ```bash
   git clone https://github.com/pimkievee/eks-vpc-module/




1. Setup AWS Credentials:

Ensure AWS CLI is properly configured with necessary permissions.

2. Deploy the VPC and EKS Cluster:

Modify configuration files as needed (e.g., VPC settings, IAM roles) and execute deployment scripts.

3. Install Istio:

Use Istio installation files and follow the provided instructions to install Istio into the cluster.

4. Deploy Add-ons:

Prometheus and Grafana: Use Helm to install Prometheus and Grafana monitoring tools.
EFS CSI Driver: Install the EFS CSI driver to enable EFS support for persistent volumes.

5. Configure Monitoring and Metrics:

Access Grafana dashboard and configure Prometheus for monitoring your cluster and applications.

Directory Structure


/scripts: Deployment scripts and automation tools.
/config: Configuration files for VPC, IAM, Kubernetes manifests, etc.
/istio: Istio installation and configuration files.
/helm-charts: Helm chart configurations for Prometheus, Grafana, etc.

Troubleshooting
If you encounter issues during deployment or configuration, please refer to the troubleshooting section in the specific component's documentation or raise an issue in this repository for assistance.


Contributing
Contributions are welcome! If you'd like to contribute, please fork the repository, make your changes, and submit a pull request.
