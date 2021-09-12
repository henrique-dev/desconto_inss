class CreateMedicProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :medic_profiles do |t|
      t.string :name
      t.string :genre
      t.date :birth_date
      t.decimal :height, precision: 4, scale: 2
      t.string :bloodtype
      t.string :telephone
      t.decimal :weight, precision: 4, scale: 2

      t.string :experience
      t.decimal :rating, precision: 4, scale: 2
      t.integer :rating_qtd, precision: 4, scale: 2

      t.boolean :complete

      t.timestamps
    end
  end
end
