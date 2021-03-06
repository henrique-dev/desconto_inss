class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :birth_date
      t.decimal :wage
      t.decimal :deduction, default: 0.0

      t.string :telephone_1
      t.string :telephone_2

      t.timestamps
    end
  end
end
