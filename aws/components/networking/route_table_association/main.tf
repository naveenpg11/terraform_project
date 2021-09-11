resource "aws_route_table_association" "route_table_association" {
  count          = length(var.subnet-ids)
  subnet_id      = var.subnet-ids[count.index]
  route_table_id = var.route-table-id
}
