resource "aws_key_pair" "dev-kp-1" {
  key_name   = var.keypair-name
  public_key = file("${path.module}/mst.pem")

  tags = {
    "Name"              = var.keypair-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "keypair_id" {
  value = aws_key_pair.dev-kp-1.id
}

output "keypair_name" {
  value = aws_key_pair.dev-kp-1.key_name
}
