json.extract! patient_file, :id, :description, :category, :photo, :created_at, :updated_at
json.url patient_patient_file_url(patient_file, format: :json)
