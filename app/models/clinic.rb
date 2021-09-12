class Clinic < ApplicationRecord
    belongs_to :clinic_profile, class_name: "ClinicProfile", optional: true, foreign_key: "clinic_profile_id"
end
