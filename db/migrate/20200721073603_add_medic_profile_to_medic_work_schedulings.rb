class AddMedicProfileToMedicWorkSchedulings < ActiveRecord::Migration[5.2]
  def change
    add_reference :medic_work_schedulings, :medic_profile, foreign_key: true
  end
end
