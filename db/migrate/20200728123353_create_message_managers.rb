class CreateMessageManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :message_managers do |t|
      t.integer :message_count
      t.boolean :active      
      t.references :patient_profile, foreign_key: true
      t.references :medic_profile, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
