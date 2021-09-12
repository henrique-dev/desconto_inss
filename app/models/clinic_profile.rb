class ClinicProfile < ApplicationRecord

  attr_accessor :name
  attr_accessor :cnpj

  has_one :clinic
  has_many :medic_work_scheduling
  has_many_attached :photos
  
  belongs_to :address, optional: true
end
