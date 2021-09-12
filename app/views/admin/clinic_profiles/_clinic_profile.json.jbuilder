json.extract! clinic_profile, :id, :description, :address_id, :created_at, :updated_at
json.url clinic_profile_url(clinic_profile, format: :json)
