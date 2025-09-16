# Microservices Deployment on Kubernetes with Helm
This project demonstrates deploying a microservices-based shopping application on Kubernetes using Helm.

The stack includes:

- Redis – caching and message broker

- Ingress-NGINX – routing external traffic to services

- cert-manager – automated TLS certificates via Let’s Encrypt

- Custom microservices – deployed as Helm charts

## Project Structure

```
helm-k8s-microservices/
│
├── infra/                 
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── variable.tf          
│   └── example.tfvars             
│
├── manifests/                  
│   ├── charts/  
│   │   ├── ingress/             
│   │   ├── redis/                            
│   │   └── shopping-ms/           
│   ├── values/         
│   ├── deployment.yaml
│   ├── helmfile.yaml                
│   ├── issuer.yaml            
│   ├── install.sh                    
│   └── uninstall.sh  
│
├── .gitignore
└── README.md   
```

## Prerequisites

- AWS CLI configured
- Helmfile installed
- kubectl installed
- Terraform installed
- Helm installed
- Git

## Deployment Steps

### 1. Infrastructure Setup with Terraform

First, set up the VPC and EKS cluster using Terraform:

```bash
cd terraform
terraform init
terraform plan
terraform apply --auto-approve
```

### 2. Configure kubectl for EKS

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>


# Confirm connection
cd kubernetes
kubectl get nodes
```

### 3. Install Nginx Ingress Controller in the cluster

```bash
# Add Helm repo for ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install ingress-nginx into its own namespace
kubectl create namespace ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.publishService.enabled=true

# Verify Ingress Controller
kubectl get pods -n ingress-nginx

# Check the LoadBalancer service

kubectl get svc -n ingress-nginx

```
The EXTERNAL-IP is what you’ll point your domain to.

### 4. Install cert-manager
```bash
kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --set installCRDs=true

# This installs cert-manager and the CRDs (otherwise issuers won’t work, which is needed for TLS).
# Verify Installation
kubectl get pods -n cert-manager
```

All pods should be Running.

### 5. Create a ClusterIssuer to use Let’s Encrypt

```bash
cd manifests/
kubectl apply -f issuer.yaml
```

### 6. Deploy Application to Kubernetes
This can be done in two ways, either use a deployment file to deploy all the micrservices or deploy each microservice as helm chart, which is more scalable.

```bash
# Create namespace
kubectl create namespace shopping-ms

# Apply using just a deployment file
kubectl apply -f deployment.yaml

# Confirm all pods and svc
kubectl get pod -n shopping-ms
kubectl get all -n shopping-ms
```
### 7. Deploy Application to k8s using helm charts
```bash
# Configure Ingress to Use TLS
# Applying using script
./install.sh

# Applying using helmfile
helmfile apply

# Confirm all pods and svc
kubectl get pod -n shopping-ms
kubectl get all -n shopping-ms
```
### 8. Access the Application
After deployment, you can access:
`https://domain-name`

### 9. Clean up
To destroy all resources:

```bash
# for application, either use script
./uninstall.sh

# or helmfile
helmfile destroy

kubectl delete namespace shopping-ms
kubectl delete namespace ingress-nginx
kubectl delete namespace cert-manager

# for infra
cd infra
terraform destroy --auto-approve
```

## Features

- Helm-first approach – each component (Redis, ingress, microservices) has its own chart.

- TLS with cert-manager – automated HTTPS using Let’s Encrypt.

- Ingress routing – domain-based access to microservices through ingress-nginx.

- Scalable setup – easily extendable with more microservices.



## Troubleshooting

Common issues and solutions:

1. **App not reachable via https://**: Make sure to install cert-manager before apply issuer.yaml
2. **TLS Issue**: Annotate letsencrypt-prod in the ingress file
3. **Letsencrypt limit exceeded**: Use letsencrypt-stage for testing then switch to prod afer it works

