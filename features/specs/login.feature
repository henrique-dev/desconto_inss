#language: pt

@smoke
Funcionalidade: Login
    
  Cenario: Login com sucesso
    Dado que estou na página de login
    Quando eu faço login com "admin1@dss.com" e "ZXDas7966mby@"
    Então devo ver "Bem vindo" na área logada

  Esquema do Cenario: Login sem sucesso
    Dado que estou na página de login
    Quando eu faço login com <email> e <senha>
    Então devo ver a mensagem de alerta <texto>

    Exemplos:
      | email                      | senha             | texto                        |
      | "novoemailteste@gmail.com" | "senha incorreta" | "Authentication failed."     |
      | "usuário incorreto"        | "teste123"        | "Email ou senha inválidos."  |
      | ""                         | "teste123"        | "An email address required." |
      | "novoemailteste@gmail.com" | ""                | "Password is required."      |