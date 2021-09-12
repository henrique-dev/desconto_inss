class MedicProfile < ApplicationRecord

    attr_accessor :cpf
    attr_accessor :uid
    attr_accessor :password
    attr_accessor :confirm_password

    attr_accessor :medic_work_scheduling

    has_one :medic, dependent: :destroy
    has_one :message_manager, dependent: :destroy
    has_many :medic_work_schedulings, dependent: :destroy
    has_many :schedulings, dependent: :destroy
    has_many :medic_evaluations, dependent: :destroy
    has_many :account_specialities
    
    has_one_attached :photo
    
    has_and_belongs_to_many :specialities

    belongs_to :address, optional: true

    validates :name, presence: true
end
