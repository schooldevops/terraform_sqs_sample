# Terraform Resource

from : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue

## Resource: aws_sqs_queue

### Example Usage

```go
resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}
```

### FIFO queue

```go
resource "aws_sqs_queue" "terraform_queue" {
  name                        = "terraform-example-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}
```

### High-throughput FIFO queue

```go
resource "aws_sqs_queue" "terraform_queue" {
  name                  = "terraform-example-queue.fifo"
  fifo_queue            = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
}
```

### Server-side encryption (SSE)

```go
resource "aws_sqs_queue" "terraform_queue" {
  name                              = "terraform-example-queue"
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}
```

## Argument Reference

- name:
  - 선택값으로 queue의 이름이다. 
  - Queue 이름들은 대문자, 소문자 ASCII 문자, 숫자, 언더스코어, 하이픈으로 1 ~ 80자 길이가 가능하다. 
  - FIFO (first-in-first-out) 큐를 위해서 이름 끝에 **.fifo** 로 끝나야 한다. 
  - 만약 이를 빼먹으면 Terraform 은 랜덤으로 유니크 이름을 할당할 것이다. 
  - name_prefix 아규먼트와 충돌한다.
- name_prefix:
  - 선택값
  - 유니크 이름으로 지정된 prefix 가 이름에 할당된다. 
  - name 아규먼트와 충돌 
- visibility_timeout_seconds:
  - 선택값 
  - queue 의 가시적인 타임아웃이다. 
  - 0 ~ 43200 (12시간) 값이 될 수 있다. 
  - 기본값은 30 이다. 
  - [AWS docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html) 에서 자세한 내용 살펴보기. 
- message_retention_seconds:
  - 선택값
  - Amazon SQS가 메시지를 보관하는 시간(초)이다. 
  - 60(1분) 에서 1209600(14일) 사이의 초단위 값이 올 수 있다. 
  - 기본값은 345600 (4일) 이다.
- max_message_size:
  - 선택값
  - Amazon SQS가 메시지를 리젝 하기 전에 가질 수 있는 바이트 수
  - 1024 바이트 (1 KiB) 에서 262144 바이트 (256 KiB) 값이 올 수 있다. 
  - 기본값은 262144 (256 KiB) 
- delay_seconds:
  - 선택값 
  - 대기열의 모든 메시지 배달이 지연되는 시간(초) 
  - 0 ~ 900 (15분) 
  - 기본값은 0 초이다.
- receive_wait_time_seconds:
  - 선택값
  - ReceiveMessage 호출이 반환되기 전에 메시지가 도착하기를 기다리는 시간 (롱 폴링)
  - 0 ~ 20 초 사이 가능
  - 기본값은 0이다. 이 의미는 즉시 결과를 반환한다는 것이다. 
- policy:
  - 선택값
  - SQS 큐를 위한 JSON 정책이다. 
  - 테라폼을 사용하여 AWS IAM 정책 문서를 구축하는 방법에 대한 자세한 내용은 [AWS IAM 정책 문서 안내서](https://learn.hashicorp.com/terraform/aws/iam-policy?_ga=2.205628954.862412804.1626044712-1648673153.1625706871)를 참조하자. 
- redrive_policy:
  - 선택값
  - Dead Letter 큐를 설정하기 위한 JSON 정책이다. [AWS 문서 참조](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html) 
  - 노트: maxReceiveCount 를 지정할때, 정수값인 5 를 설정해야한다. "5" 로 하면 안된다. 
- fifo_queue:
  - 선택값
  - FIFO 큐를 지정할지 여부 
  - 기본값은 false 이며, 이는 표준 대기열을 만드는 것이다. 
- content_based_deduplication:
  - 선택값
  - FIFO 대기열에 대한 콘텐츠 기반 중복 제거를 활성화 한다. 
  - 더 많은 정보를 위해서는 [다음](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing) 참조 
- kms_master_key_id:
  - 선택값
  - CMK(AWS가 관리하는 고객 마스터키)의 아이디를 설정한다. 
  - 더 많은 정보를 위해서는 [다음](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-sse-key-terms)을 살펴보자. 
- kms_data_key_reuse_period_seconds:
  - 선택값 
  - 초로 시간을 설정하며, SQS 가 AWS KMS를 다시 호출하기 전에 메시지를 암호화 하거나, 해독하기 위해 데이터 키를 재사용할 수 있는 시간 
  - 시간값은 60초 ~ 86400초 (24시간) 을 지정할 수 있다. 
  - 기본값은 300이다. (5분)
- deduplication_scope:
  - 선택값
  - 메시지 중복 제거가 메시지 그룹 또는 큐 수준에서 발생하는지 여부를 지정한다. 
  - 가능한 값은 messageGroup 그리고 queue (기본) 이다. 
- fifo_throughtput_limit:
  - 선택값
  - FIFO 큐 처리량 쿼타가 전체 큐에 지정될지, 각 메시지 그룹마다 지정될지 설정한다. 
  - 유효한 값은 perQueue(기본) 그리고 perMessageGroupId 이다. 
- tags:
  - 선택값
  - 대기열에 할당할 태그 맵

## Attributes Reference

- id: 생성된 Queue 의 URL 이다. 
- arn: SQS 의 ARN 이다. 
- tags_all: 태그의 맵으로 리소스에 할당된 태그들이다. 
- url: id 와 동일하다. SQS 의 URL 이다. 

