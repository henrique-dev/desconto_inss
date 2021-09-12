class CreateAccountSpecialities < ActiveRecord::Migration[5.2]
  def change
    create_table :account_specialities do |t|
      t.datetime :used_at
      t.boolean :used
      t.references :speciality, foreign_key: true
      t.references :patient_account, foreign_key: true
      t.references :medic_profile, foreign_key: true

      t.timestamps
    end

    add_index :account_specialities, [:patient_account_id, :speciality_id], :unique => true, :name => "ac_sp_index"
  end
end
