class CreatePatientAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_accounts do |t|
      t.references :patient_profile, foreign_key: true

      t.timestamps
    end
  end
end
