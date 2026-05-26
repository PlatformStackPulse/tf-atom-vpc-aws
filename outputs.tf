output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the VPC"
  value       = try(aws_vpc.this[0].id, null)
}

output "arn" {
  description = "ARN of the VPC"
  value       = try(aws_vpc.this[0].arn, null)
}

output "cidr_block" {
  description = "CIDR block of the VPC"
  value       = try(aws_vpc.this[0].cidr_block, null)
}

output "default_route_table_id" {
  description = "ID of the default route table"
  value       = try(aws_vpc.this[0].default_route_table_id, null)
}

output "default_security_group_id" {
  description = "ID of the default security group"
  value       = try(aws_vpc.this[0].default_security_group_id, null)
}
