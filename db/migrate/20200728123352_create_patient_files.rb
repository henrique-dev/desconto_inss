class CreatePatientFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_files do |t|
      t.string :description
      t.integer :category
      t.references :patient_account, foreign_key: true
      t.timestamps
    end
  end
end
