class PatientFile < ApplicationRecord
    belongs_to :patient_account
    has_one_attached :photo
  
    scope :from_patient_account,     lambda {|id| where(patient_account_id: id)}
end