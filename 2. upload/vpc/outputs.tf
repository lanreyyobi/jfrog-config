output "private" {
  value = aws_subnet.private.*.id
}

output "public" {
  value = aws_subnet.public.*.id
}

output "vpc-id" {
  value = aws_vpc.main.id
}
