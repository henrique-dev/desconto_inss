json.array!(@schedulings) do |scheduling|
    json.id scheduling.id
    json.for_date scheduling.for_date.strftime("%d/%m/%Y")
    json.for_time scheduling.for_time.strftime("%H:%M")
    json.consulted scheduling.consulted
    json.patient_profile scheduling.patient_profile
    json.clinic scheduling.medic_work_scheduling.clinic_profile.clinic
    json.speciality scheduling.medic_work_scheduling.speciality
end