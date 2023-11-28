
Executar o Docker:

Para iniciar os contêineres Docker, utilize o seguinte comando:

```sh
docker-compose up -d
```

Acessar o container do PostgreSQL e adicionar arquivos TSV no volume:

Acesse o container do PostgreSQL e adicione os arquivos TSV no diretório /var/lib/postgresql/data/:

```sh
docker exec -it NOME_DO_SEU_CONTAINER_PSQL bash
```

Lembre-se de substituir NOME_DO_SEU_CONTAINER_PSQL pelo nome real do seu contêiner PostgreSQL.

Forçar atualização:

Para forçar a atualização do banco de dados, utilize o seguinte comando:

```sh
docker exec -it postgresql psql -U postgres -f /docker-entrypoint-initdb.d/base.sql
```