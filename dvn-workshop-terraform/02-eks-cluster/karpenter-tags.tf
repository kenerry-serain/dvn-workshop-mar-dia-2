resource "aws_ec2_tag" "subnet" {
  count = length(data.aws_subnets.private.ids)

  resource_id = data.aws_subnets.private.ids[count.index]
  key         = "karpenter.sh/discovery"
  value       = aws_eks_cluster.this.id
}

resource "aws_ec2_tag" "security_group" {
  resource_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  key         = "karpenter.sh/discovery"
  value       = aws_eks_cluster.this.id
}
