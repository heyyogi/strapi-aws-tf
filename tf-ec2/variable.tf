variable "ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default = "ami-019715e0d74f695be" 
}

variable "key_name" {
    description = "The key name to use for the EC2 instance"
    type        = string
    default     = "strapi-key"
}

variable "instance_type" {
    description = "The type of instance to use for the EC2 instance"
    type        = string
    default     = "t2.medium"
}