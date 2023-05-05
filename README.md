# Provisioning an AWS Instance with a Docker Container
This project demonstrates how to use Terraform to provision an AWS EC2 instance, configure security groups, and deploy a Docker container on it.

## Prerequisites
- AWS account and AWS Access Key and Secret Access Key
- Terraform v0.12 or higher
- Docker

## Code Explanation
The Terraform code creates the following AWS resources:

- An Elastic IP (`aws_eip`) to associate with the instance
- An EC2 instance (`aws_instance`) running on the Ubuntu AMI with a `t2.micro` instance type
- A Security Group (`aws_security_group`) allowing inbound traffic on ports `80`, `443`, and `22`

The `user_data` field in the `aws_instance` resource points to a shell script that installs Docker and launches a Docker container. The script performs the following steps:

- Installs the necessary dependencies for Docker installation
- Adds the Docker GPG key and repository to the system
- Installs Docker Community Edition
- Pulls a Docker image from Docker Hub
- Runs the Docker container in the background with the -d flag
- Exposes port 80 on the host to port 80 on the Docker container

The Docker container in this example runs an image called `daisukebtw/docker-terraform-image`, which is tagged as dev.

## How to Use
1. Clone the repository `git clone https://github.com/daisukebtw/Simple-Docker-in-Terraform`
2. Create an `aws-credentials.tf` file in the root directory of the project with your AWS Access Key and Secret Access Key:

            provider "aws" {
                  access_key = "<your_access_key>"
                  secret_key = "<your_secret_access_key>"
                  region     = "eu-central-1"
            }
3. Run terraform init to initialize the working directory
4. Run terraform apply to create the AWS resources and deploy the Docker container
5. When you're done, run terraform destroy to delete the resources and terminate the EC2 instance

Note: Make sure to modify the code as per your requirements.

## Author
Made by Vitali Aleksandrov on 5-April-2023.
