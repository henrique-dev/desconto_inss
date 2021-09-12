#json.partial! "patient/patient_profiles/patient_profile", patient_profile: @patient_profile
#json.array! @schedulings, partial: "schedulings/scheduling", as: :scheduling

json.id @patient_profile.id
json.name @patient_profile.name
json.genre @patient_profile.genre
json.birth_date @patient_profile.birth_date
json.height @patient_profile.height
json.bloodtype @patient_profile.bloodtype
json.telephone @patient_profile.telephone
json.weight @patient_profile.weight
json.email @patient_profile.patient.email