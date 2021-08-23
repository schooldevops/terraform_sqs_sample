resource "aws_sqs_queue" "terraform_queue" {
  for_each = toset(var.QUEUES)
  name =  each.key == "fifo" ? "${var.SQS_NAME}.${each.key}" : "${var.SQS_NAME}"
  delay_seconds = var.DELAY_SEC
  max_message_size = var.MAX_MESSAGE_SIZE
  visibility_timeout_seconds = var.VISIBILITY_TIMEOUT_SECONDS
  message_retention_seconds = var.MESSAGE_RETENTION_SECONDS
  receive_wait_time_seconds = var.RECEIVE_WAIT_TIME_SECONDS
  fifo_queue = each.key == "fifo" ? true: false
  content_based_deduplication = each.key == "fifo" ? true: false
}