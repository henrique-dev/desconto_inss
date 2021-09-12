class CreateClinicProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :clinic_profiles do |t|
      t.string :description
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
