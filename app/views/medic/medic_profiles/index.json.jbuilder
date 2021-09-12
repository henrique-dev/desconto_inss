#json.array! @medic_profiles, partial: "medic_profiles/medic_profile", as: :medic_profile

json.array!(@medic_profiles) do |medic_profile|
    json.id medic_profile.id
    json.name medic_profile.name
    json.genre medic_profile.genre
    json.birth_date medic_profile.birth_date
    json.height medic_profile.height
    json.bloodtype medic_profile.bloodtype
    json.telephone medic_profile.telephone
    json.weight medic_profile.weight
    json.created_at medic_profile.created_at
    json.updated_at medic_profile.updated_at
    json.address_id medic_profile.address_id
    json.specialities medic_profile.specialities
    json.medic_work_scheduling medic_profile.medic_work_scheduling
    json.clinic medic_profile.medic_work_scheduling.clinic_profile.clinic
    json.clinic_profile medic_profile.medic_work_scheduling.clinic_profile
end

#json.array! @medic_profiles, :id, :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_at, :updated_at, :address_id