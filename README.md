# Terraform Module Project

A reusable and environment-based Terraform project for provisioning AWS infrastructure using **Terraform Modules**.

This project follows a modular structure where common AWS resources are defined as reusable modules and separate configurations are maintained for **Development, Test, and Production** environments.

## Architecture

```text
                    Terraform
                        |
          +-------------+-------------+
          |             |             |
         Dev           Test          Prod
          |             |             |
          +-------------+-------------+
                        |
                Reusable Modules
                        |
        +---------------+---------------+
        |               |               |
       EC2         Security Group       S3
```

## Project Structure

```text
terraform-project/
│
├── .gitignore
├── README.md
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars.example
│   │   └── .terraform.lock.hcl
│   │
│   ├── test/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars.example
│   │   └── .terraform.lock.hcl
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars.example
│       └── .terraform.lock.hcl
│
└── modules/
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── s3/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── security-group/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## AWS Resources

The project provisions AWS infrastructure using reusable modules.

### EC2 Module

The EC2 module is responsible for creating EC2 instances with configurable:

* AMI
* Instance type
* Subnet
* Key pair
* Root volume size
* Environment-specific configuration

### Security Group Module

The security group module provides configurable inbound rules such as:

* SSH
* HTTP
* Custom TCP/UDP rules

Ingress rules can be passed from the environment configuration.

### S3 Module

The S3 module creates environment-specific S3 buckets with configurable:

* Bucket name
* Versioning
* Force destroy behavior

## Environments

The project separates infrastructure configuration by environment.

| Environment | Purpose                    |
| ----------- | -------------------------- |
| Dev         | Development infrastructure |
| Test        | Testing and validation     |
| Prod        | Production infrastructure  |

Each environment uses the same reusable modules but can provide different values for:

* AWS region
* VPC
* Subnet
* AMI
* Instance type
* Storage size
* Security group rules
* S3 configuration

This allows infrastructure to remain consistent while environment-specific values are kept separate.

## Terraform Concepts Demonstrated

This project demonstrates practical Terraform concepts including:

* Terraform Modules
* Input Variables
* Output Values
* Environment separation
* Resource configuration
* Variable files
* Reusable infrastructure
* AWS provider
* EC2
* Security Groups
* S3
* Terraform dependency management
* `.terraform.lock.hcl`
* Terraform state management
* Terraform backend configuration
* Infrastructure as Code

## Prerequisites

Install the following before using the project:

* Terraform
* AWS CLI
* An AWS account
* Git

Verify Terraform:

```bash
terraform version
```

Verify AWS CLI:

```bash
aws --version
```

Configure AWS credentials:

```bash
aws configure
```

You can also use an appropriate AWS IAM role or other supported AWS authentication mechanism.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Shivasai-21/Terraform-Module-Project.git
```

Move into the project:

```bash
cd Terraform-Module-Project
```

### 2. Select an environment

For example, Development:

```bash
cd environments/dev
```

### 3. Create your Terraform variables file

Copy the example file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

On Windows PowerShell:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Update `terraform.tfvars` with your own AWS values.

Example:

```hcl
region      = "ap-south-1"
environment = "dev"
project     = "myapp"

vpc_id    = "vpc-xxxxxxxx"
subnet_id = "subnet-xxxxxxxx"
ami_id    = "ami-xxxxxxxx"

instance_type    = "t3.micro"
root_volume_size = 20
key_name         = "your-key-pair-name"
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Validate the configuration

```bash
terraform validate
```

### 6. Format the Terraform files

```bash
terraform fmt -recursive
```

### 7. Review the execution plan

```bash
terraform plan
```

### 8. Apply the infrastructure

```bash
terraform apply
```

Review the resources Terraform plans to create and confirm when prompted.

### 9. Destroy the infrastructure

When the environment is no longer required:

```bash
terraform destroy
```

## Using Another Environment

The same process can be followed for Test or Production.

### Test

```bash
cd environments/test
terraform init
terraform validate
terraform plan
terraform apply
```

### Production

```bash
cd environments/prod
terraform init
terraform validate
terraform plan
terraform apply
```

Always review the production plan carefully before applying changes.

## Terraform Modules

The environment configurations call reusable modules instead of defining every resource directly.

Example:

```hcl
module "ec2" {
  source = "../../modules/ec2"

  environment      = var.environment
  project          = var.project
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_id        = var.subnet_id
  key_name         = var.key_name
  root_volume_size = var.root_volume_size
}
```

This approach avoids duplicating the same infrastructure code across environments.

## State Management

Terraform state is intentionally excluded from the Git repository.

The following files/directories should not be committed:

```text
.terraform/
*.tfstate
*.tfstate.*
terraform.tfstate.d/
*.tfplan
```

State should be stored using an appropriate remote backend for team environments.

For example, an AWS S3 backend can be used for centralized state management.

## Security

Do not commit sensitive information to GitHub.

The following files are intentionally excluded:

```text
terraform.tfvars
*.auto.tfvars
*.auto.tfvars.json
secret.tfvars
secrets.tfvars
credentials.tfvars
```

Use the provided example files instead:

```text
terraform.tfvars.example
```

Never commit:

* AWS access keys
* AWS secret keys
* Passwords
* API tokens
* Private keys
* Sensitive credentials
* Terraform state containing sensitive information

## Recommended Terraform Workflow

```text
Write Terraform Code
        |
        v
terraform fmt
        |
        v
terraform init
        |
        v
terraform validate
        |
        v
terraform plan
        |
        v
terraform apply
        |
        v
Infrastructure Created
```

For changes:

```text
Modify Code
    |
    v
terraform fmt
    |
    v
terraform validate
    |
    v
terraform plan
    |
    v
Review Changes
    |
    v
terraform apply
```

## Benefits of This Structure

This project structure provides:

* Reusable Terraform modules
* Environment isolation
* Less code duplication
* Easier infrastructure maintenance
* Consistent AWS resource configuration
* Easier scaling to additional environments
* Better separation of environment-specific values
* Cleaner Infrastructure-as-Code practices

## Future Improvements

Possible enhancements include:

* Remote S3 backend with DynamoDB locking or the current recommended AWS state-locking approach
* CI/CD using Jenkins or GitHub Actions
* Terraform plan and apply automation
* Terraform security scanning
* Checkov or tfsec integration
* Terraform Cloud/HCP Terraform integration
* AWS IAM role-based authentication
* Additional reusable modules
* Infrastructure monitoring
* Automated environment deployments

## Author

**Shivasai Chinthala**

DevOps Engineer | AWS | Kubernetes | Terraform | Jenkins | Docker

GitHub:
https://github.com/Shivasai-21
