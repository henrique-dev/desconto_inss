class MessageManager < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :patient_profile, optional: true
  belongs_to :medic_profile, optional: true
  belongs_to :admin, optional: true  

  attr_accessor :last_active_message

  def last_message
    self.messages.where(active: true).last
  end

end
