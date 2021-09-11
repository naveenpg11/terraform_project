output "vpc_id" {
  value = module.vpc.vpc_id
}
output "alb_dns_name" {
  value = module.vpc.alb-dns_name
}

output "https_api_proxy" {

  value = module.expose_api_https.https_endpoint
}

output "https_api_https_private" {
  value = module.expose_api_https_private.https_endpoint
}






