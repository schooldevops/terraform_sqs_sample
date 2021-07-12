# Create AWS SQS with Terraform

## 구성 

- AWS SQS Terraform 을 위한 샘플 

### Terraform 정보 

- terraform 
  - provider.tf: 테라폼 생성을 위한 제공자 정보 및 credential 정보 
  - vars.tf: 변경 가능 속성값 ${value} 로 placeholder 작업 필요
  - main.tf: SQS를 생성하기 위한 terraform 파일 

### test sqs with go

- sqs_send_message.go: 메시지 전송을 테스트용, SQS가 생성되고 난 후  qURL 에 신규 생성된 SQS URL 을 추가해서 테스트 
- sqs_receive_message.go: 메시지 수신을 위한 테스트용 소스, SQS가 생성되고 난 후  qURL 에 신규 생성된 SQS URL 을 추가해서 테스트 

## 실행방법 

### Terraform 

**AWS Credential 설치 **

```go
aws configure --profile schooldevops
```

생성된 aws credential 값을 추가한다. 

**Terraform 초기화 **

이미 terraform 이 설치 되어 있다고 가정한다. 

```go
cd terraform
terraform init 

terraform plan <- 플랜으로 테라폼 생성 정보를 확인해본다. 

terraform apply <- 테라폼을 활용하여 AWS 에 SQS생성 
```

### Test Code

- Test Code 를 실행하기 위해서는 go 가 설치 되어 있다고 가정한다. 

```go
cd go_sqs_sample

go mod download <- 필요한 의존성을 다온로드 한다. 
```

**Message 전송하기.**

```go
go run sqs_send_message.go
```

**Message 수신하기.**

```go
go run sqs_receive_message.go
```


