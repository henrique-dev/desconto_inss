class AccountSpeciality < ApplicationRecord
  belongs_to :speciality
  belongs_to :patient_account
  belongs_to :medic_profile

  scope :from_patient_account,     lambda {|id| where(patient_account_id: id)}

  def generate_account_speciality
    as = AccountSpeciality.new
    as.used = false
    as.speciality = Speciality.sample
    as.patient_account = PatientAccount.first
    as.medic_profile = as.speciality.medic_profiles.first
    as.save
  end
end
