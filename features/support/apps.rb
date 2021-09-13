# Declarando a classe App que e onde as pages serao instanciadas
class App
  def home
    Home.new
  end

  def login
    Login.new
  end
end
