class Address < ApplicationRecord
    has_one :patient_profile, dependent: :destroy
    has_one :medic_profile, dependent: :destroy
    has_one :clinic_profile, dependent: :destroy
end
