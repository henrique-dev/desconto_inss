class Speciality < ApplicationRecord
    has_many :medic_work_schedulings, dependent: :destroy
    has_and_belongs_to_many :medic_profiles, dependent: :destroy
    has_many :account_specialities, dependent: :destroy
    has_many :schedulings, dependent: :destroy

    validates :name, presence: true
    validates :description, presence: true
end
