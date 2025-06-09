# OxsBank

O **OxsBank** é uma API bancária desenvolvida para gerenciar contas empresariais e realizar transações financeiras de forma segura e eficiente. A criação de contas é restrita a empresas, exigindo um CNPJ válido e um documento em base64.

## Funcionalidades

- **Criação de Contas Empresariais**: Apenas empresas podem criar contas, sendo necessário informar um CNPJ e um documento em base64.
- **Gerenciamento de Contas**:
  - Criar conta (consulta automática na API ReceitaWS).
  - Listar todas as contas.
  - Consultar conta por ID (formato GUID).
  - Excluir conta.
- **Transações Bancárias**:
  - Depósitos.
  - Saques.
  - Transferências entre contas.
  - Consulta de saldo e extrato.

## Tecnologias Utilizadas

- **.NET 8**
- **Entity Framework Core**
- **PostgreSQL**
- **Docker**
- **Clean Architecture**
- **API ReceitaWS** (consulta de dados da empresa pelo CNPJ)
- **Swagger** (documentação e testes da API)
- **Serilog** (logging estruturado)
- **Autenticação JWT** (implementação planejada para o futuro)

## Configuração do Ambiente

### 1. Requisitos
- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Docker](https://www.docker.com/get-started)
- [PostgreSQL](https://www.postgresql.org/download/)

### 2. Clonar o Repositório
```bash
git clone https://github.com/dev-matheusv/desafio-backend-2025.git
cd desafio-backend-2025
```

### 3. Configurar o Banco de Dados
- Se estiver rodando localmente, crie um banco de dados `oxsbankdb`.
- Atualize o `appsettings.json` com as credenciais corretas:
```json
"ConnectionStrings": {
  "DefaultConnection": "Host=localhost;Database=oxsbankdb;Username=seu_usuario;Password=sua_senha"
}
```

### 4. Executar com Docker
```bash
docker-compose up
```
Isso iniciará a API e o banco de dados PostgreSQL.

### 5. Aplicar Migrações do EF Core
```bash
dotnet ef database update
```

### 6. Acessar a API
- API: `http://localhost:5000`
- Swagger: `http://localhost:5000/swagger`

## Testando a API

### Criar Conta (Somente CNPJ Válido)
```bash
curl -X POST http://localhost:5000/api/accounts -H "Content-Type: application/json" -d '{
  "cnpj": "12345678000195",
  "documentoBase64": "dGVzdGU=..."
}'
```
A API consultará automaticamente os dados da empresa na ReceitaWS.

### Consultar Conta por ID (Formato GUID)
```bash
curl -X GET http://localhost:5000/api/accounts/{id}
```

### Listar Todas as Contas
```bash
curl -X GET http://localhost:5000/api/accounts
```

### Excluir Conta
```bash
curl -X DELETE http://localhost:5000/api/accounts/{id}
```

### Depositar
```bash
curl -X POST http://localhost:5000/api/transactions/deposit -H "Content-Type: application/json" -d '{
  "contaId": "guid-da-conta",
  "valor": 1000.00
}'
```

### Sacar
```bash
curl -X POST http://localhost:5000/api/transactions/withdraw -H "Content-Type: application/json" -d '{
  "contaId": "guid-da-conta",
  "valor": 500.00
}'
```

### Transferir
```bash
curl -X POST http://localhost:5000/api/transactions/transfer -H "Content-Type: application/json" -d '{
  "contaOrigemId": "guid-origem",
  "contaDestinoId": "guid-destino",
  "valor": 200.00
}'
```

### Consultar Saldo
```bash
curl -X GET http://localhost:5000/api/transactions/{id}/balance
```

### Consultar Extrato
```bash
curl -X GET http://localhost:5000/api/transactions/{id}/statement
```

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

