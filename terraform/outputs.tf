output "sqs_queue_id" {
  description = "SQS URL을 반환한다."
  value = tomap({"fifo" = aws_sqs_queue.terraform_queue["fifo"].id, "standard" = aws_sqs_queue.terraform_queue["standard"].id})
}

output "sqs_queue_name" {
  description = "SQS Queue 의 이름"
  value = tomap({"fifo" = aws_sqs_queue.terraform_queue["fifo"].name, "standard" = aws_sqs_queue.terraform_queue["standard"].name})
}