data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    #sid     = "EKSClusterAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["${var.service_name}.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "this" {

  name                  = var.role_name
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.cluster_iam_policy
  policy_arn = each.value
  role       = aws_iam_role.this.name
}