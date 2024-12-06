#output "url" {
#  value = module.ec2_instance.url
#}
#output "instance-id" {
#  value = module.ec2_instance.instance-id
#}

output "all_instance_ids" {
value = [aws_instance.ec2.*.id]
}
output "first_instance_id" {
value = aws_instance.ec2.0.id
}