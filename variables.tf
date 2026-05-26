variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid CIDR notation."
  }
}

variable "instance_tenancy" {
  description = "Tenancy of instances (default, dedicated, host)"
  type        = string
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "instance_tenancy must be default, dedicated, or host."
  }
}

variable "enable_dns_support" {
  description = "Whether DNS resolution is supported"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether instances get public DNS hostnames"
  type        = bool
  default     = true
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Whether to assign an IPv6 CIDR block"
  type        = bool
  default     = false
}
