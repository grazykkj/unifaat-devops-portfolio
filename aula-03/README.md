# Aula 03 — Terraform + IAM | Grazielli Monteiro de Lima (6325165)

## Design da Estrutura IAM

Os grupos separam responsabilidades. `6325165-technova-developers` concentra o acesso de leitura ao S3 para desenvolvimento, enquanto `6325165-technova-platform-eng` adiciona a capacidade operacional de consultar, iniciar e parar instancias EC2 identificadas com a tag `Project = TechNova`, alem de trabalhar com objetos S3 do projeto.

Juliana e Lucas pertencem somente a `developers`. Rafael pertence aos dois grupos: recebe a leitura comum dos desenvolvedores e as permissoes adicionais de plataforma. A associacao e declarada individualmente com `aws_iam_user_group_membership`, o que torna a distribuicao de acessos auditavel no codigo.

## Principio do Menor Privilegio

Menor privilegio significa conceder somente as permissoes necessarias para uma tarefa, somente sobre os recursos necessarios. Neste projeto isso aparece de duas formas principais:

- A policy de leitura permite apenas `s3:ListBucket` e `s3:GetObject` nos buckets `technova-*`; nao concede escrita, exclusao ou acesso a outros buckets.
- A policy de plataforma permite apenas as acoes EC2 de consulta, inicializacao e parada. As duas acoes que alteram estado exigem que a instancia tenha `Project = TechNova`.

Tambem existe um `Deny` explicito para acoes destrutivas nos desenvolvedores. Um `Deny` sempre prevalece sobre um `Allow`. Usar `AmazonS3FullAccess` eliminaria esses limites: os usuarios poderiam criar, alterar e apagar objetos de qualquer bucket S3 acessivel pela conta.

## Diagrama de Permissoes

```text
Juliana ─┐
Lucas   ─┼─> developers ─> s3-read + deny-destructive ─> S3 technova-*
Rafael  ─┘

Rafael ───> platform-eng ─> ec2-s3-full ─> EC2 com tag Project=TechNova
                                             S3 technova-*

EC2 service ─> 6325165-technova-ec2-role ─> policy ec2-app-data-rw
              └> instance profile ─> instancia EC2 ─> S3 technova-app-data-*
```

## Tags

Os recursos IAM que aceitam tags recebem as tags obrigatorias via `default_tags`: Project, ManagedBy, Aluno, RA, Disciplina e Aula. O recurso de grupo IAM e as associacoes de usuario/policy nao oferecem suporte a tags na API AWS/Terraform; seus nomes, paths e vinculos mantem a identificacao e rastreabilidade.

## Comandos Utilizados

```powershell
cd aula-03
terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform show -no-color tfplan | Tee-Object terraform-plan-output.txt
terraform apply tfplan
terraform destroy
```

> Execute `terraform apply` somente com uma conta AWS de laboratorio autorizada e rode `terraform destroy` ao terminar os testes.

## Reflexao

No Console AWS e facil criar permissoes diretamente e perder a visao de quem mudou o que. Com Terraform, a configuracao passa por revisao de codigo, o plano mostra as alteracoes antes da aplicacao e o repositorio registra sua evolucao. Isso torna a estrutura mais repetivel, auditavel e segura para a equipe.
