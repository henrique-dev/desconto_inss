# README

BASE DE DADOS: postgresql
VERSÃO RAILS: 5.2.0
VERSÃO RUBY: 2.7.1

Para construir a base de dados e fazer a migração rode o comando:
```
rails dev:setup
```

Para rodar os testes use o comando (somente teste de login implamentado):
```
cucumber -t @smoke
```

Para rodar o job de atualização de salário inicie o sidekiq:
```
bundle exec sidekiq
```

E depois rode o comando no console do rails:
```
WageUpdateJob.perform_later(<porcentagem_aumento>)
```