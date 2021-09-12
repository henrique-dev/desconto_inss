#json.array! @schedulings, partial: "schedulings/scheduling", as: :scheduling
json.array!(@schedulings) do |scheduling|
    json.id scheduling.id
    json.for_date scheduling.for_date
    json.for_time scheduling.for_time
    json.consulted scheduling.consulted
    json.rated scheduling.rated
    @medic_profile = scheduling.medic_work_scheduling.medic_profile
    json.medic_profile @medic_profile
    if @medic_profile.photo.attached? && photo = @medic_profile.photo
        json.medic_profile_photo rails_blob_path(photo, disposition: "attachment", only_path: true)
    else
        json.medic_profile_photo nil
    end
    json.clinic scheduling.medic_work_scheduling.clinic_profile.clinic
    json.speciality scheduling.medic_work_scheduling.speciality
end