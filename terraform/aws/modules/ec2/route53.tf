resource "aws_route53_record" "default" {
  count   = length(var.dns_zone_id) > 0 ? var.instance_count : 0
  zone_id = var.dns_zone_id
  name    = "${var.hostname}-${count.index}"
  type    = var.type
  ttl     = var.ttl
  records = [element(aws_instance.default[*].private_dns, count.index)]
}
