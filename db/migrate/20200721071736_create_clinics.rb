class CreateClinics < ActiveRecord::Migration[5.2]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :cnpj

      t.timestamps
    end
  end
end
