#json.partial! "medic/medic_profiles/medic_profile", medic_profile: @medic_profile

json.id @medic_profile.id
json.name @medic_profile.name
json.genre @medic_profile.genre
json.birth_date @medic_profile.birth_date
json.height @medic_profile.height
json.bloodtype @medic_profile.bloodtype
json.telephone @medic_profile.telephone
json.weight @medic_profile.weight
json.email @medic_profile.medic.email