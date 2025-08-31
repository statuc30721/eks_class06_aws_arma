# We set all variables in this file."
variable "enable_kubeconfig" {
  default     = true
  description = "Set to false to skip local kubeconfig update"
}

# Variables for project.
variable "region" {
  default = "us-east-1"

}

# Virtual Private Cloud
variable "vpc_cidr" {
  default = "10.30.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR blocks for each private and public subnet"
  type = object({
    private_zone1 = string
    private_zone2 = string
    public_zone1  = string
    public_zone2  = string
  })
  # Set default values for each subnet.
  default = {
    private_zone1 = "10.30.0.0/19"
    private_zone2 = "10.30.32.0/19"
    public_zone1  = "10.30.64.0/19"
    public_zone2  = "10.30.96.0/19"
  }
}

# Set values for each AWS Availability Zone.
locals {
  zone1 = "${var.region}a"
  zone2 = "${var.region}b"
}

# Set cluster name

variable "cluster_name" {
  default     = "staging"
  type        = string
  description = "AWS EKS Cluster Name"
  nullable    = false
}

# Set remote client IP address for security group rules.

variable "client_ip" {
  type    = string
  default = "0.0.0.0/0"
  # client_ip_addr =  # insert IP address and CIDR in this field.

}

# Set OIDC certificate. 
# Need to add this asap.