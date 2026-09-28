region      = "ap-south-1"
environment = "dev"
project     = "myapp"

# Replace with your real values
vpc_id    = "vpc-053b19582375ad6bc"
subnet_id = "subnet-0ee2823e54e26bc99"
ami_id    = "ami-066c4849e6b3a1e3d"

instance_type    = "t3.micro"
root_volume_size = 20
key_name         = "Devops-Kp"

ingress_rules = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
bucket_name        = "myapp-dev-storage-change-me"
versioning_enabled = true
force_destroy      = true
