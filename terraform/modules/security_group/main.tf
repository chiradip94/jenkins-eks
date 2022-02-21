resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.security_group_description
  vpc_id      = var.vpc_id
  tags = var.tags
}

resource "aws_security_group_rule" "cluster" {
  for_each          = { for k, v in var.security_group_rules : k => v }
  security_group_id = aws_security_group.this.id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type

  cidr_blocks       = try([each.value.cidr_blocks], null)
  self              = try(each.value.self, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}