class CreateMedicEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :medic_evaluations do |t|
      t.string :description
      t.integer :rating

      t.references :medic_profile, foreign_key: true
      t.references :patient_profile, foreign_key: true
      t.references :scheduling, foreign_key: true

      t.timestamps
    end
  end
end
