class CreateSchedulings < ActiveRecord::Migration[5.2]
  def change
    create_table :schedulings do |t|
      t.date :for_date
      t.time :for_time
      t.boolean :consulted
      t.boolean :rated
      t.datetime :consulted_at
      t.references :medic_work_scheduling, foreign_key: true
      t.references :medic_profile, foreign_key: true
      t.references :patient_profile, foreign_key: true
      t.references :speciality, foreign_key: true

      t.timestamps
    end
  end
end
