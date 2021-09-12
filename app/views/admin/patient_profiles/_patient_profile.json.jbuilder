json.extract! patient_profile, :id, :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_at, :updated_at
json.url patient_profile_url(patient_profile, format: :json)
