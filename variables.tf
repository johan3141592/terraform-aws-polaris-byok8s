variable "autoscaling_max_size" {
  description = "The maximum number of concurrent workers."
  type        = number
  default     = 64
}

variable "cluster_master_role_arn" {
  description = "Cluster master role ARN."
  type        = string
}

variable "kubernetes_version" {
    description = "Kubernetes version."
    type        = string
    default     = "1.27"
}

variable "name_prefix" {
  description = "Name prefix for all resources created."
  type        = string
  default     = "rubrik-byok8s"
}

# If private endpoint access is enabled, then K8s API access from worker nodes
# stays within the customer's VPC. Note that this doesn't disable public access,
# cluster remains accessible from public internet as well. For more information,
# see https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html.
variable "enable_private_endpoint_access" {
  description = "Enable EKS private endpoint access."
  type        = bool
  default     = false
}

# If restrict public endpoint access is enabled, then the public access to the
# K8s API server endpoint is restricted to the RSC deployment IPs and the
# Bastion IP, otherwise the endpoint remains accessible to the public internet.
# When enabled, we enable the private endpoint access, otherwise there will be
# no way for workers to communicate with the API server.
variable "restrict_public_endpoint_access" {
  description = "Restrict EKS public endpoint access."
  type        = bool
  default     = false
}

# The IP addresses provided will automatically be turned into CIDR addresses.
variable "rsc_deployment_ips" {
  description = "Rubrik Security Cloud deployment IPs."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnet IDs."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "worker_instance_profile" {
  description = "Worker instance profile."
  type        = string
}

variable "worker_instance_type" {
  description = "Worker instance type."
  type        = string
  default     = "m5.xlarge"
}
