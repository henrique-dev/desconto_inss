class PatientAccount < ApplicationRecord
  belongs_to :patient_profile, optional: true
  has_many :account_specialities
  has_many :patient_files
end
