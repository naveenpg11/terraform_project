# terraform_practice

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




### Future Iteration
1. Remove hardcoding of any resource configuration and make it parameterized, which will help us to tweak the configuration based on environment we are going to deploy in. Example. Each environment [Eg: Dev, Staging, Prog] might require differnet replica to handle load
2. Use Terragrunt to manage Terraform's Configuration DRY, will be usefull when we deal with multiple environments
3. Ensure Naming convention is followed and consistent in all components. This will help us to identify our resource when we deploy our application in multiple region, environment and accounts. Or even in client environment. 
4. Better use of resource tags, which will help  to segregate our resources and also to filter cost incured 
5. The Code structure can be even more modularized, which will help other develpers to jump in and contribute.


### Production Ready Checklist :
1. State management has to be configured. (Also Enable version control)
2. Enabling HTTPS via Custom DNS and ACM 
3. Cloudwatch Resource Monitoring, Alerting has to be introduced in terraform
4. ALB/ VPC Flow Logs has to be Enabled for better visibility
5. Benchmark of the application has to be done to set autoscaling  units
