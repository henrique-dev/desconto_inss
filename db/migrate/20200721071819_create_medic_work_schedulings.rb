class CreateMedicWorkSchedulings < ActiveRecord::Migration[5.2]
  def change
    create_table :medic_work_schedulings do |t|
      t.integer :duration
      t.time :start_at
      t.time :end_at
      t.time :interval_start_at
      t.time :interval_end_at
      t.string :info
      t.string :days_of_week
      t.references :clinic_profile, foreign_key: true
      t.references :speciality, foreign_key: true
      t.string :complement

      t.integer :per_day
      t.date :last
      t.integer :counter_of_day

      t.string :medic_name
      t.string :clinic_name
      t.string :speciality_name

      t.timestamps
    end
  end
end
