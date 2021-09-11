## Add terraform and grunt installer scripts here

#!/bin/bash


#sudo wget -q -O /bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v0.18.7/terragrunt_linux_amd64"
#sudo chmod +x /bin/terragrunt

sudo apt install unzip

wget https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip
unzip terraform_0.14.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version

sudo apt-add-repository ppa:ansible/ansible-2.5 -y
sudo apt-get update
sudo apt-get install default-jdk -y
sudo apt install ansible -y
