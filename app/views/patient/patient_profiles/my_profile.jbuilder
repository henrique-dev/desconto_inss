json.id @patient_profile.id
json.name @patient_profile.name
json.genre @patient_profile.genre
json.birth_date @patient_profile.birth_date
json.height @patient_profile.height
json.bloodtype @patient_profile.bloodtype
json.telephone @patient_profile.telephone
json.weight @patient_profile.weight
json.email @patient_profile.patient.email
json.complete @patient_profile.complete
if @patient_profile.photo.attached? && photo = @patient_profile.photo
    json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
else
    json.photo nil
end