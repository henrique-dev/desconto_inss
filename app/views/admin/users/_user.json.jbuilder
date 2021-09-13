json.extract! user, :id, :name, :cpf, :birth_date, :created_at, :updated_at
json.url user_url(user, format: :json)
