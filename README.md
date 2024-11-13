# README

# Desafio técnico - Vertical Logística

# O desafio
Temos uma demanda para integrar dois sistemas. O sistema legado que possui um arquivo de
pedidos desnormalizado, precisamos transformá-lo em um arquivo json normalizado. E para isso
precisamos satisfazer alguns requisitos.

# Objetivo do desafio
Faça um sistema que receba um arquivo via API REST e processe-o para ser retornado via API
REST.

# Entrada de dados
O arquivo do sistema legado possui uma estrutura em que cada linha representa uma parte de um
pedido. Os dados estão padronizados por tamanho de seus valores, respeitando a seguinte tabela:

| campo            | tamanho | tipoSinal           |
|------------------|---------|---------------------|
| id usuario       | 10      | numerico            |
| nome             | 45      | texto               |
| id pedido        | 10      | numerico            |
| id produto       | 10      | numerico            |
| valor do produto | 12      | decimal             |
| data de compra   | 8       | numerico (yyyymmdd) |

# Saída de dados
A saída de dados deverá ser disponibilizada via api REST considerando a estrutura base de payload
de response. Considere a consulta geral de pedidos e, também, a inclusão de filtros:

1. id do pedido;
2. intervalo de data de compra (data início e data fim);


# Key words
* Testes
* Lógica
* Simplicidade
* SOLID
* Linguagem (não estamos falando de framework)
* Automação (Ex: Build, Coverage)
* Desenho da API
* Git

### Tecnologias usadas
```
Ruby 3.3.5
Rails - 8.0.0
O banco de dados utilizado para persistência dos dados foi SQLite.
```

### Para rodar o projeto:
```
$ git clone https://github.com/laisnsc/normalizer_api.git

$ bundle install

$ rails db:create db:migrate
```

### Documentação dos endpoints (Postman)
```
https://documenter.getpostman.com/view/18568837/2sAY55ZxLp    
```