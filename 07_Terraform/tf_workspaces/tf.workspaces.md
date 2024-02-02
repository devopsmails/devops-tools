What is tf workspace & use of it?
------------------------------
Terraform workspaces are a way to isolate different environments of the same infrastructure configuration.   
Each workspace has its own state file, which stores the current state of the infrastructure managed by Terraform.   
This allows you to safely make changes to one environment without affecting the others.  

Workspaces are useful for:
--------------------------
Managing multiple environments of the same infrastructure  
Testing new infrastructure changes in a safe environment.  
Collaborating on infrastructure changes.  

```
ls
cd .\modules\
terraform workspace show
terraform workspace new dev
ls
terraform init
terraform workspace show
terraform apply
terraform workspace show

terraform workspace new pprod
terraform workspace show
terraform init
terraform apply

terraform workspace new prod
terraform workspace list
terraform workspace show
terraform init
terraform apply
tree

terraform destroy --auto-approve
terraform show
terraform workspace show
terraform workspace delete prod

terraform workspace select dev
terraform workspace show
terraform workspace delete prod
terraform destroy --auto-approve

terraform workspace select pprod
terraform workspace delete dev
terraform workspace list
terraform destroy --auto-approve

terraform workspace select default
terraform workspace delete pprod

```
