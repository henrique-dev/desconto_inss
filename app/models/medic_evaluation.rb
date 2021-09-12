class MedicEvaluation < ApplicationRecord
  belongs_to :patient_profile, optional: true  
  belongs_to :medic_profile, optional: true
  belongs_to :scheduling, optional: true
end
