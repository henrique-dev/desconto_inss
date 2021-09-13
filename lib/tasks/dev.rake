namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    # if Rails.env.development?
    show_spinner('[:spinner] Deletando o banco de dados') { `rails db:drop` }
    show_spinner('[:spinner] Criando o banco de dados') { `rails db:create` }
    show_spinner('[:spinner] Migrando o banco de dados') { `rails db:migrate` }
    show_spinner('[:spinner] Populando o banco de dados') { `rails db:seed` }
    # else
    puts "Você não está em ambiente de desenvolvimento!"
    # end
  end

  task clear_sessions: :environment do
    if Rails.env.development?
      sql = 'DELETE FROM sessions WHERE updated_at < DATE_SUB(NOW(), INTERVAL 1 DAY);'
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def show_spinner(msg)
    spinner = TTY::Spinner.new(msg, format: :classic)
    spinner.auto_spin
    yield
    spinner.success
  end
end
