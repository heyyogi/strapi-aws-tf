# Connecting to Strapi using Terraform

## 🚀 Provision & Access Strapi

This setup uses **Terraform `user_data`** to automatically install and run Strapi on an AWS EC2 instance.

### Steps

1. **Apply Terraform**
   ```bash
   terraform init
   terraform apply -auto-approve
