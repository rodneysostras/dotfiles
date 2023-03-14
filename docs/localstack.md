# LocalStack - Emule ambiente AWS localmente

LocaStack é uma solução que possibilita obter um ambiente Cloud AWS completo em sua máquina, sem custo.

Neste tutorial irei mostrar uma forma que acredito ser a mais simples de construir uma sandbox para desenvolver, testar ou até mesmo para estudar.

> **OBS:** A versão gratuita não tem persistência do ambiente.

## 🛠️ Ferramentas

Neste tutorial irei aborda o uso das seguinte ferramentas para construir nosso ambiente, são elas;

- **terraform:** Uma ferramenta que possibilita criar infraestrutura a parti de código.
- **awscli:** Um recurso para gerenciar os produtos da AWS via linha de comando.
- **docker:** Uma plataforma que constrói, gerencia e implantar aplicações em containers.
- **docker-compose:** Um orquestrador de container Docker, facilita o provisionamento e gerenciamento de multi-containers.

## ⚙️ Instalação

Presumindo que ja possua o docker + docker-compose instalado vamos prosseguir na construção do ambiente.

Caso não tenha segue aqui o link, [get-docker](https://docs.docker.com/get-docker/).

### ✨ LocalStack

Existe algumas formas de utilizar o LocalStack, uma delas e utilizando o docker.

	Pre-requisitos
	- docker
	- docker-compose (version 1.9.0+)
  
 Iremos criar um arquivo `docker-compose.yml` com as seguintes extruções.
 
```yml
version: "3.8"

services:
  localstack:
    container_name: "${LOCALSTACK_DOCKER_NAME-localstack_main}"
    image: localstack/localstack:latest
    ports:
      - "0.0.0.0:53:53"
      - "0.0.0.0:443:443"
      - "127.0.0.1:4566:4566"            # LocalStack Gateway
      - "127.0.0.1:4510-4559:4510-4559"  # external services port range
    environment:
	    - SERVICES=${SERVICES:-}
      - DEBUG=${DEBUG:-}
      - LAMBDA_EXECUTOR=${LAMBDA_EXECUTOR:-}
      - DOCKER_HOST=${DOCKER_HOST:-unix:///var/run/docker.sock}
    volumes:
      - "${LOCALSTACK_VOLUME_DIR:-./volume}:/var/lib/localstack"
      - "${DOCKER_HOST:-/var/run/docker.sock:/var/run/docker.sock"
```

**OBS:** Nesse arquivo acima se atente em verificar o caminho do `docker.sock`.

Dentro da pasta onde esta o arquvio podemos provisionar o contênier com o seguinte comando `docker-compose up -d`.

> **Referência** \
> https://github.com/localstack/localstack/blob/master/docker-compose.yml \
> https://docs.localstack.cloud/getting-started/installation/#docker-compose

### 💻 awscli

Existe algumas formas de instalar awscli, pode ser pelo gerenciador de pacotes do seu sistema operacional, pelas orientações da AWS, ou até mesmo via python com o sequinte comando `python3 -m pip install awscli`.

Apôs a instalação para utilização da ferramenta com `LocalStack` e necessario passar a seguinte flag `--endpoint-url=http://localhost:4566`, ficaria algo assim;

```
aws --endpoint-url=http://localhost:4566 lamda list-functions
```

> **DICA:** Uma sugestão e criar um alias para este comando em seus sistema operacional.

Caso ocorra algum erro parecido com isso `connection aborted - Resource temporarily unavailable`, pode ser por causa do IP do container, para resolver siga estes passos;

1. Execute o comando para identificar o nome/container-id do LocalStack: `docker ps -a`
2. Agora execute este comando para identificar o `IpAddress` do container: `docker inspect <nome ou container-id>` | `docker inspect localstack_main`

Agora e so utilizar o IpAddress do container no lugar do localhost, algo assim `aws --endpoint-url=http://172.20.0.2:4566`.

> **Referência** \
> https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html \
> https://www.vivaolinux.com.br/dica/Como-criar-um-ALIAS

### 🌐 terraform

Com terraform instalado, segue o link na referência, iremos utilizar uma configuração que redireciona a conexão para LocalStack, igual como fizemos com `awscli`.

Abaixo segue a configuração base para utilizar com LocalStack

<details>
  <summary><strong>localstack.tf</strong></summary>
    
```
provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    acm                      = "http://localhost:4566"
    amplify                  = "http://localhost:4566"
    apigateway               = "http://localhost:4566"
    appconfig                = "http://localhost:4566"
    applicationautoscaling   = "http://localhost:4566"
    appsync                  = "http://localhost:4566"
    athena                   = "http://localhost:4566"
    autoscaling              = "http://localhost:4566"
    backup                   = "http://localhost:4566"
    batch                    = "http://localhost:4566"
    cloudformation           = "http://localhost:4566"
    cloudfront               = "http://localhost:4566"
    cloudsearch              = "http://localhost:4566"
    cloudtrail               = "http://localhost:4566"
    cloudwatch               = "http://localhost:4566"
    cloudwatchlogs           = "http://localhost:4566"
    codecommit               = "http://localhost:4566"
    cognitoidentity          = "http://localhost:4566"
    cognitoidp               = "http://localhost:4566"
    configservice            = "http://localhost:4566"
    docdb                    = "http://localhost:4566"
    dynamodb                 = "http://localhost:4566"
    ec2                      = "http://localhost:4566"
    ecr                      = "http://localhost:4566"
    ecs                      = "http://localhost:4566"
    efs                      = "http://localhost:4566"
    eks                      = "http://localhost:4566"
    elasticache              = "http://localhost:4566"
    elasticbeanstalk         = "http://localhost:4566"
    elb                      = "http://localhost:4566"
    emr                      = "http://localhost:4566"
    es                       = "http://localhost:4566"
    firehose                 = "http://localhost:4566"
    glacier                  = "http://localhost:4566"
    glue                     = "http://localhost:4566"
    iam                      = "http://localhost:4566"
    iot                      = "http://localhost:4566"
    iotanalytics             = "http://localhost:4566"
    iotevents                = "http://localhost:4566"
    kafka                    = "http://localhost:4566"
    kinesis                  = "http://localhost:4566"
    kinesisanalytics         = "http://localhost:4566"
    kinesisanalyticsv2       = "http://localhost:4566"
    kms                      = "http://localhost:4566"
    lakeformation            = "http://localhost:4566"
    lambda                   = "http://localhost:4566"
    mediaconvert             = "http://localhost:4566"
    mediastore               = "http://localhost:4566"
    mediastoredata           = "http://localhost:4566"
    mq                       = "http://localhost:4566"
    mwaa                     = "http://mwaa.localhost.localstack.cloud:4566"
    neptune                  = "http://localhost:4566"
    organizations            = "http://localhost:4566"
    qldb                     = "http://localhost:4566"
    rds                      = "http://localhost:4566"
    redshift                 = "http://localhost:4566"
    resourcegroups           = "http://localhost:4566"
    resourcegroupstaggingapi = "http://localhost:4566"
    route53                  = "http://localhost:4566"
    route53resolver          = "http://localhost:4566"
    s3                       = "http://s3.localhost.localstack.cloud:4566"
    s3control                = "http://localhost:4566"
    sagemaker                = "http://localhost:4566"
    secretsmanager           = "http://localhost:4566"
    serverlessrepo           = "http://localhost:4566"
    servicediscovery         = "http://localhost:4566"
    ses                      = "http://localhost:4566"
    sns                      = "http://localhost:4566"
    sqs                      = "http://localhost:4566"
    ssm                      = "http://localhost:4566"
    stepfunctions            = "http://localhost:4566"
    sts                      = "http://localhost:4566"
    swf                      = "http://localhost:4566"
    timestreamwrite          = "http://localhost:4566"
    transfer                 = "http://localhost:4566"
    waf                      = "http://localhost:4566"
    wafv2                    = "http://localhost:4566"
    xray                     = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "bucket_test" {
  bucket = "bucket-test"

  tags = {
    Name        = "bucket teste"
    Environment = "${terraform.workspace}"
  }

  livecycle {
    prevent_destroy = true
  }
}

terraform {
  backend "s3" {
    bucket = "bucket-teste"
    key    = "terraform.tfstate"
    region = "us-east-1"

    endpoint                    = "http://localhost:4566"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    dynamodb_table              = "terraformlock_teste"
    dynamodb_endpoint           = "http://localhost:4566"
    encrypt                     = true
  }
}

```
</details>

> **DICA:** Caso queira utilizar o localstack em um projeto existente (esta em produção) você criar um arquvivo com sufixo `_override.tf`, desta forma ira sobre escrever recursos, agora deixe o `terraform.backend` e `aws_s3_bucket` com nome de recurso igual que e usado no projeto para poder sobre escrever. 

> **OBS:** Ao usar awscli e ocorreu aquele erro de conexão será necessario mudar neste arquivo para o IpAddress do container, observe que tem alguns endpoint com domínio esses não são necessário mudar.

> **Referência** \
> https://developer.hashicorp.com/terraform/downloads?product_intent=terraform

## 🚀 Como utilizar

Tudo certo até aqui, ferramentas instaladas, localstack rodando via docker e configuração do endpoint do terraform feita.

Agora vamos utilizar a `awscli` para criar algumas coisas, por exemplo o `bucket` e `dynamoDB`, estes recursos serão usado no backend do terraform que e uma técnica normalmente utilizada.

1. **Vamos criar bucket s3**
```
aws -endpoint-url=http://localhost:4566 s3 mb s3://bucket-teste 
```
Você pode verificar com seguinte comando 
```
aws -endpoint-url=http://localhost:4566 s3 ls s3://bucket-teste
```
2. **Agora iremos criar o dynamoDB**
```
aws dynamodb --endpoint-url=http://localhost:4566 create-table \
  --table-name terraformlock_teste \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```
Verifique com seguinte comando;
```
aws dynamodb --endpoint-url=http://localhost:4566 list-tables
```
3. **Executando o Terraform**
	3.1. terrafom init
  3.2. terraform validate
  3.4. terraform plan
  3.5. terraform apply
  
Agora você possui uma Cloud AWS em sua maquina, use com moderação. 
