#json.array! @patient_files, partial: "patient/patient_files/patient_file", as: :patient_file
json.patient_files(@patient_files) do |patient_file|
    json.id patient_file.id
    json.description patient_file.description
    json.category patient_file.category
    json.created_at patient_file.created_at.strftime("%d/%m/%Y")
    if patient_file.photo.attached? && photo = patient_file.photo
        json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
    else
        json.photo nil
    end
end