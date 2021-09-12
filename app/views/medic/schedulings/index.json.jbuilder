#json.array! @schedulings, partial: "schedulings/scheduling", as: :scheduling
json.array!(@schedulings) do |scheduling|
    json.id scheduling.id
    json.today (scheduling.for_date == Date.today)
    json.for_date scheduling.for_date    
    json.for_time scheduling.for_time
    json.consulted scheduling.consulted
    json.medic_profile scheduling.medic_work_scheduling.medic_profile
    json.clinic scheduling.medic_work_scheduling.clinic_profile.clinic
    json.speciality scheduling.medic_work_scheduling.speciality
end