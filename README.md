# terraform_Challenge

Terraform Code to create AWS Infrastructure which:
- Runs the container workload (we recommend ECS)
- Exposes the application to the internet over HTTPS in some way

## PreRequisite
- Install Terraform
- Configure AWS CLI 
- Replace `container_image_id` to you ecr image uri.

## Run Below commands

```sh
terraform init
terraform plan -var-file="values.json"  
terraform apply -var-file="values.json"  
```

