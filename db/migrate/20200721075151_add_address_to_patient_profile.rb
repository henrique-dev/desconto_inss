class AddAddressToPatientProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :patient_profiles, :address, foreign_key: true
  end
end