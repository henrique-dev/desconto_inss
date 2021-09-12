json.partial! "patient/schedulings/scheduling", scheduling: @scheduling
json.medic_profile @scheduling.medic_work_scheduling.medic_profile
json.clinic @scheduling.medic_work_scheduling.clinic_profile.clinic
json.speciality @scheduling.medic_work_scheduling.speciality
json.address @scheduling.medic_work_scheduling.clinic_profile.address