# Aula 01 — Fundamentos de Git e Docker

## O que aprendi

- O Git permite registrar mudanças do projeto em commits com mensagens claras e rastreáveis.
- Branches isolam o desenvolvimento de uma funcionalidade antes de integrá-la à branch principal.
- O merge reúne o trabalho da branch de funcionalidade com o histórico da branch principal.
- O Docker empacota a aplicação e suas dependências em uma imagem reproduzível.
- O Dockerfile organiza as instruções necessárias para criar e executar o container.

## Comandos Git praticados

- `git init`
- `git checkout -b feature/aula-01-app`
- `git add`
- `git commit`
- `git log --oneline`
- `git merge`

## Comandos Docker praticados

- `docker build -t portfolio-aula01:1.0 .`
- `docker run -d --name portfolio-test -p 3000:3000 portfolio-aula01:1.0`
- `docker ps`
- `docker logs portfolio-test`
- `docker stop portfolio-test`
- `docker rm portfolio-test`

## Como executar este container

```bash
cd aula-01/app
docker build -t portfolio-aula01:1.0 .
docker run -d --name portfolio-test -p 3000:3000 portfolio-aula01:1.0
curl http://localhost:3000
curl http://localhost:3000/health
```

## Dificuldades encontradas

Uma dificuldade foi entender que a aplicação precisa expor a porta interna do container e que ela deve ser mapeada para a porta local no comando `docker run`. A organização do Dockerfile em camadas, copiando primeiro o `package.json`, também ajuda a reaproveitar o cache do build quando apenas o código da aplicação muda.
