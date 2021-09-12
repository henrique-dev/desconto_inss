class AddMedicProfileToMedics < ActiveRecord::Migration[5.2]
  def change
    add_reference :medics, :medic_profile, foreign_key: true
  end
end
