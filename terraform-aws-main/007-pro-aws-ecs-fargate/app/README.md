# AWS ECS Fargate Tutorial: Criando e deployando uma aplicação Node.js

Série de vídeos no Youtube explicando como construir e deployar uma aplicação Node.js usando o AWS ECS Fargate.

## Vídeos no Youtube
01. [Entendendo o que será construído](https://youtu.be/SwUC4sXEcqE)
02. [Implementando aplicação Node.js](https://youtu.be/UuSM26i39Fk)
03. [Criando imagem do Docker](https://youtu.be/MM-UTLKQ2Xc)
04. [Configurando AWS ECR](https://youtu.be/NF8iZp6rqps)
05. [Configurando VPC, Internet Gateway, Subnets e Route Tables](https://youtu.be/9x_GQanUWJM)
06. [Configurando o Load Balancer](https://youtu.be/IM6k8gM7co8)
07. [Finalizando a configuração do cluster do ECS e acessando a aplicação](https://youtu.be/UQnJyLnfbgw)
08. [Alternativa ao NAT Gateway - Subnet Públicas](https://youtu.be/_eEZhXsUL0g)
09. [Alternativa ao NAT Gateway - VPC Endpoints](https://youtu.be/68cERUTP2kE)
10. [Conectando o serviço à um banco de dados no AWS RDS](https://youtu.be/IFovNm2Rm8M)
11. [Alternativa ao NAT Gateway - EC2 NAT Instances](https://youtu.be/sYqNcH9dD0M)
12. [Subindo uma nova versão da nossa aplicação no ECR e ECS](https://youtu.be/_eyU6A7bCqA)
13. [Deletando todos os recursos da nossa aplicação](https://youtu.be/erdoH56RarM)

## Diagrama de arquitetura

![App Screenshot](diagram.jpg)

## Links

- [Playlist dos vídeos](https://www.youtube.com/playlist?list=PLWQmZVQayUUI5RinDqpoIXiRYWy5YZKjs)
- [Ferramenta CIDR](https://cidr.xyz/)
- [O que é CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
- [Fargate Network Mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-tasks-networkmode)
- [Analogia de uma VPC completa](https://start.jcolemorrison.com/aws-vpc-core-concepts-analogy-guide/)
- [Post oficial da AWS sobre a rede de uma task no Fargate](https://aws.amazon.com/blogs/compute/task-networking-in-aws-fargate/)


## Ordem de deleção dos recursos na AWS
01. ECS Service
02. Task definition
03. Load balancer
04. Target group
05. Service security group
06. Load balancer security group
07. NAT Gateways
08. Subnets
09. Dettach Internet Gateway
10. Delete Internet Gateway
11. Route tables
12. VPC
13. ECS Cluster
14. ECR
15. IAM
16. Cloudwatch
