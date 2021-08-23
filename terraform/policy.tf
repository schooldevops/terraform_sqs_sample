resource "aws_sqs_queue_policy" "terraform_queue_policy" {

  for_each = toset(var.QUEUES)

  queue_url = aws_sqs_queue.terraform_queue[each.key].id

  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "sqspolicy",
    "Statement": [
      {
        "Sid": "First",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "sqs:SendMessage",
        "Resource": "${aws_sqs_queue.terraform_queue[each.key].arn}"
      }
    ]
  }
  POLICY
}

# Arguments

# - `queue_url`: 필수 값이며, SQS Queue 의 URL을 적용할 정책 대상 Queue이다.
# - `policy`: SQS queue 를 위한 JSON 정책 정보이다. 더 자세한 정보는 [AWS IAM Policy Docuemnt Guide](https://learn.hashicorp.com/terraform/aws/iam-policy?_ga=2.28436220.1701080660.1629674124-1648673153.1625706871) 살펴보자. 

# {
#   "Sid": "Receiver",
#   "Effect": "Allow",
#   "Principal": "*",
#   "Action": [
#     "sqs:ReceiveMessage",
#     "sqs:DeleteMessage",
#     "sqs:DeleteMessageBatch",
#   ]
#   "Resource": "${aws_sqs_queue.terraform_aueue.arn}"
# },
# {
#   "Sid": "Administrator",
#   "Effect": "Allow",
#   "Principal": "*",
#   "Action": [
#     "sqs:CreateQueue",
#     "sqs:DeleteQueue",
#   ]
#   "Resource": "${aws_sqs_queue.terraform_aueue.arn}"
# }