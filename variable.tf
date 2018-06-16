variable "aws_access_key" {
  description = "AWS access key"
}
variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "region" {
  description = "Name of AWS region (default:ap-south-1)"
  default = "ap-south-1"
}
variable "private_key_path" {
  default = "/home/soumya/.ssh/id_ssh"
}
variable "prefix" {
  default = "soumya"
}

/*
variable "instance_count" {
  description = "Number of data nodes in the cluster (default is list[1,2,2])"
  default = [1,0,0]
}
*/
variable "elasticsearch_kibana_count"{
  default = 1
}
variable "forwarder_count" {
  #default = 0
}
variable "source_aggregater_count" {
  #default = 0
}
variable "destination_aggregater_count" {
  #default = 0
}

variable "key_name" {
  default = "my_key"
}
variable "network_address_space" {
  default = "10.11.14.0/16"
}
variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}
variable "subnet2_address_space" {
  default = "10.1.1.0/24"
}

variable "test-ami" {
  type = "map"
  default = {
    ap-south-1 = "ami-76d6f519"
  }
}
variable "environment_tag" {
  default = "Mesos_Development_ENV"
}
variable "bucket_name" {
  default = "s3"
}
variable "public_key_path" {
  description = "Path to my public key"
  default = "/home/ec2-user/.ssh/authorized_keys"
}
variable "management_iam_roles" {
  description = "List of IAM role ARNs from which to permit management traffic (default ['*']).  Note that a client must match both the IP address and the IAM role patterns in order to be permitted access."
  type        = "list"
  default     = ["*"]
}
