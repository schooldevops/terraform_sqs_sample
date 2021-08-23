output "sqs_queue_id" {
  description = "SQS URL을 반환한다."
  value = tomap({
    fifo = lookup(zipmap(var.QUEUES, var.QUEUES), "fifo", null) != null ? aws_sqs_queue.terraform_queue["fifo"].id : null, 
    standard = lookup(zipmap(var.QUEUES, var.QUEUES), "standard", null)  != null ? aws_sqs_queue.terraform_queue["standard"].id : null
  })
}

output "sqs_queue_name" {
  description = "SQS Queue 의 이름"
  value = tomap({
    fifo = lookup(zipmap(var.QUEUES, var.QUEUES), "fifo", null) != null ? aws_sqs_queue.terraform_queue["fifo"].name : null, 
    standard = lookup(zipmap(var.QUEUES, var.QUEUES), "standard", null) != null ? aws_sqs_queue.terraform_queue["standard"].name: null
  })
}