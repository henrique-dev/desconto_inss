json.array!(@medic_profiles) do |medic_profile|
    json.id medic_profile.id
    json.name medic_profile.name
    json.genre medic_profile.genre
    json.birth_date medic_profile.birth_date
    json.height medic_profile.height
    json.bloodtype medic_profile.bloodtype
    json.telephone medic_profile.telephone
    json.weight medic_profile.weight
    json.experience medic_profile.experience
    json.rating medic_profile.rating
    json.rating_qtd medic_profile.rating_qtd    
    json.created_at medic_profile.created_at
    json.updated_at medic_profile.updated_at
    json.address_id medic_profile.address_id
    json.specialities medic_profile.specialities
    @medic_work_scheduling = medic_profile.medic_work_scheduling
    json.medic_work_scheduling @medic_work_scheduling
    json.clinic @medic_work_scheduling.clinic_profile.clinic
    @clinic_profile = @medic_work_scheduling.clinic_profile
    json.clinic_profile @clinic_profile
    if (@clinic_profile.photos)
        json.photos(@clinic_profile.photos) do |photo|
            json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
        end
    end
    if medic_profile.photo.attached? && photo = medic_profile.photo
        json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
    else
        json.photo nil
    end
end

#json.array! @medic_profiles, :id, :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_at, :updated_at, :address_id