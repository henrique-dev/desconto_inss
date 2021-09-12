class AddPatientProfileToPatients < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :patient_profile, foreign_key: true
  end
end
