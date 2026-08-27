# Analise do Uso de IA - Aula 02 TF

## Prompt Utilizado

> Crie um docker-compose.yml para uma aplicacao Node.js 20 com Express que usa PostgreSQL 15 como banco de dados e Redis 7 como cache. A API roda na porta 3000. O PostgreSQL precisa de volume nomeado para persistencia. Todos os servicos devem estar na mesma rede bridge customizada. Use variaveis de ambiente com interpolacao de arquivo .env. Adicione healthchecks, depends_on com condition, e restart policy unless-stopped.

## Output Original do Kiro

```yaml
version: '3.8'
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      DB_HOST: postgres
      REDIS_HOST: redis
    depends_on:
      - postgres
      - redis
    networks:
      - technova

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: technova
      POSTGRES_USER: technova
      POSTGRES_PASSWORD: senha123
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - technova

  redis:
    image: redis:7-alpine
    networks:
      - technova

volumes:
  postgres-data:
networks:
  technova:
    driver: bridge
```

## Alteracoes que Fiz Manualmente

| O que mudei | Por que |
|---|---|
| Substitui valores fixos por `${VARIAVEL}` | Credenciais e configuracoes devem vir do arquivo `.env`, sem ficarem expostas no Compose. |
| Adicionei healthchecks ao PostgreSQL e Redis | A API so deve iniciar depois que banco e cache estiverem prontos. |
| Troquei `depends_on` em lista por condicoes `service_healthy` | A lista apenas garante a ordem de inicio, nao a disponibilidade do servico. |
| Inclui `restart: unless-stopped` nos tres servicos | O ambiente volta a funcionar apos uma falha ou reinicio do Docker. |
| Adicionei comentarios ao arquivo final | Eles tornam a finalidade de cada secao mais clara para manutencao. |
| Removi `version: '3.8'` | O Docker Compose atual usa a Compose Specification e nao exige essa chave. |

## O que o Kiro Acertou

- Definiu os tres servicos solicitados: API, PostgreSQL e Redis.
- Escolheu as imagens `postgres:15-alpine` e `redis:7-alpine` corretas.
- Configurou um volume nomeado para persistir os dados do PostgreSQL.
- Colocou os servicos na mesma rede bridge customizada.
- Construiu a API com o Dockerfile local.

## O que o Kiro Errou ou Omitiu

- Deixou a senha do banco e enderecos dos servicos hardcoded.
- Nao adicionou healthchecks para PostgreSQL e Redis.
- Nao configurou `depends_on` com `condition: service_healthy`.
- Nao incluiu a politica de reinicio `unless-stopped`.
- Publicou a porta com valor fixo em vez de usar as variaveis `API_HOST_PORT` e `PORT`.

## Minha Avaliacao

- **Tempo economizado usando IA:** aproximadamente 15 minutos para montar a estrutura inicial.
- **Tempo gasto validando/corrigindo:** aproximadamente 20 minutos para revisar requisitos, seguranca e disponibilidade.
- **Nota para o output da IA (1-10):** 6.
- **Usaria novamente para este tipo de tarefa?** Sim. A IA e util para criar um ponto de partida, mas a validacao manual e indispensavel para evitar credenciais expostas e configuracoes incompletas.
