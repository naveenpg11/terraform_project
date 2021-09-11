resource "aws_efs_file_system" "msd" {
  creation_token = var.efs-name
  encrypted      = true
  tags = {
    "Name"              = var.efs-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

resource "aws_efs_mount_target" "msd" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.msd.id
  subnet_id       = var.subnets[count.index]
  security_groups = var.sgs
}

output "efs-dns" {
  value = aws_efs_file_system.msd.dns_name
}
