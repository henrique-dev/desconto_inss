json.extract! medic_profile, :id, :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_at, :updated_at
json.url medic_profile_url(medic_profile, format: :json)
