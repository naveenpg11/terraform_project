resource "aws_instance" "ec2" {
  count                                = var.ec2-instance-count
  ami                                  = var.instance-image
  instance_type                        = var.instance-type
  subnet_id                            = var.subnet-ids[count.index % length(var.subnet-ids)]
  key_name                             = var.keypair-name
  vpc_security_group_ids               = var.security-group-id
  associate_public_ip_address          = var.associate_public_ip_address
  user_data                            = var.user-data
  iam_instance_profile                 = var.iam_instance_profile
  disable_api_termination              = var.enable-deletion-protection
  instance_initiated_shutdown_behavior = var.auto-shutdown

  root_block_device {
    volume_size           = var.volume-size
    encrypted             = true
    delete_on_termination = var.enable-deletion-protection ? false : true
    tags = {
      "Name"              = "${var.ec2-name}-0${count.index + var.start-index}"
      "Application"       = var.appname
      "Application Owner" = var.appowner
      "Environment"       = var.environment
      "Application Role"  = var.approle
    }
  }

  tags = {
    "Name"              = "${var.ec2-name}-0${count.index + var.start-index}"
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
    "Backup"            = var.backup_enabled == "true" ? "Enabled" : "Disabled"
  }
}

output "ec2-instance" {
  value = aws_instance.ec2
}

output "ec2_arn" {
  value = aws_instance.ec2[0].arn
}

