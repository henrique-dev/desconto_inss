#json.array! @medic_work_schedulings, partial: "medic/medic_work_schedulings/medic_work_scheduling", as: :medic_work_scheduling
json.array!(@medic_work_schedulings) do |medic_work_scheduling|
    json.id medic_work_scheduling.id
    json.clinic medic_work_scheduling.clinic_profile.clinic
    json.speciality medic_work_scheduling.speciality

    #:id, :per_day, :last, :counter_of_day, :info, :days_of_week, :clinic_profile_id, :speciality_id, :complement, :created_at, :updated_at
end