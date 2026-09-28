region      = "ap-south-1"
environment = "prod"
project     = "myapp"

# Replace with your real values
vpc_id    = "vpc-053b19582375ad6bc"
subnet_id = "subnet-08d93493302fe3025"
ami_id    = "ami-066c4849e6b3a1e3d"

instance_type    = "c7i-flex.large"
root_volume_size = 20
key_name         = null

ingress_rules = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  },
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# S3 storage (bucket names must be globally unique)
bucket_name        = "myapp-prod-storage-change-me"
versioning_enabled = true
force_destroy      = false
