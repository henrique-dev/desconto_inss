json.extract! user_profile, :id, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_at, :updated_at
json.url user_profile_url(user_profile, format: :json)
