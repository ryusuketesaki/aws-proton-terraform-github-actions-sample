/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:808225968452:environment/tesaki-test-env-230130

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "ClusterName" {
  value = aws_ecs_cluster.cluster.name
}

output "ClusterArn" {
  value = aws_ecs_cluster.cluster.arn
}

output "ServiceTaskDefExecutionRoleArn" {
  value = aws_iam_role.service-task-def-execution-role.arn
}

output "SnsTopicArn" {
  value = aws_sns_topic.ping_topic.arn
}

output "SnsTopicName" {
  value = aws_sns_topic.ping_topic.name
}

output "SnsRegion" {
  value = local.region
}

output "VpcId" {
  value = module.vpc.vpc_id
}

output "PublicSubnetOneId" {
  value = module.vpc.public_subnets[0]
}

output "PublicSubnetTwoId" {
  value = module.vpc.public_subnets[1]
}

output "PrivateSubnetOneId" {
  value = module.vpc.private_subnets[0]
}

output "PrivateSubnetTwoId" {
  value = module.vpc.private_subnets[1]
}

output "CloudMapNamespaceId" {
  value = aws_service_discovery_private_dns_namespace.cloud_map_namespace.id
}

output "EcsHostSecurityGroupId" {
  value = aws_security_group.ecs_host_security_group.id
}
