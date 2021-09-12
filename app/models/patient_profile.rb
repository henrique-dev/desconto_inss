class PatientProfile < ApplicationRecord

    attr_accessor :cpf
    attr_accessor :uid
    attr_accessor :password
    attr_accessor :password_confirmation
    attr_accessor :created_by_admin

    has_one :patient, dependent: :destroy
    has_one :patient_account, dependent: :destroy
    has_one :message_manager, dependent: :destroy
    has_many :schedulings, dependent: :destroy
    has_many :medic_evaluations, dependent: :destroy
    has_one :account, class_name: "PatientAccount", dependent: :destroy

    has_one_attached :photo

    belongs_to :address, optional: true

    validates :name, presence: true
    #validates :genre, presence: true

end
