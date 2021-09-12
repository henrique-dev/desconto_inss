class AddAddressToMedicProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :medic_profiles, :address, foreign_key: true
  end
end
