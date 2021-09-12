#json.array! @account_specialities, partial: "patient/account_specialities/account_speciality", as: :account_speciality
json.array!(@account_specialities) do |account_speciality|
    json.speciality account_speciality.speciality
    #json.for_date scheduling.for_date
    #json.consulted scheduling.consulted
    json.medic_profile account_speciality.medic_profile
    json.at account_speciality.created_at.strftime("%d / %m / %Y")
    #json.clinic scheduling.medic_work_scheduling.clinic_profile.clinic
    #json.speciality scheduling.medic_work_scheduling.speciality
end