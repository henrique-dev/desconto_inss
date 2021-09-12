json.partial! "medic/schedulings/scheduling", scheduling: @scheduling
@patient_profile = @scheduling.patient_profile
json.patient_profile @patient_profile
json.patient_address @patient_profile.address
json.medic_profile @scheduling.medic_work_scheduling.medic_profile
json.clinic @scheduling.medic_work_scheduling.clinic_profile.clinic
json.speciality @scheduling.medic_work_scheduling.speciality
json.address @scheduling.medic_work_scheduling.clinic_profile.address
json.specialities @specialities
if @patient_profile.photo.attached? && photo = @patient_profile.photo
    json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
else
    json.photo nil
end