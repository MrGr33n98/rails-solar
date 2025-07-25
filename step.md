# Passo a Passo para Rodar o Projeto

Este guia descreve como configurar o ambiente e executar a aplicação Rails.

## 1. Pré-requisitos

- Ruby 3.2.2 instalado (pode usar rbenv, rvm ou asdf).
- SQLite3 instalado para o banco de dados.
- Bundler (`gem install bundler`).

## 2. Clonar o repositório

```bash
git clone <URL-do-repositorio>
cd rails-solar
```

## 3. Instalar dependências

Execute:

```bash
bundle install
```

Opcionalmente, rode o script de configuração padrão do projeto:

```bash
bin/setup
```

## 4. Preparar o banco de dados

```bash
bin/rails db:create    # cria o banco
bin/rails db:migrate   # aplica as migrações
bin/rails db:seed      # (opcional) carrega dados de exemplo
```

## 5. Iniciar o servidor

```bash
bin/rails server
```

A aplicação estará disponível em `http://localhost:3000`.

## 6. Executar os testes

- Testes RSpec: `bundle exec rspec`
- Testes padrão do Rails: `bin/rails test`


