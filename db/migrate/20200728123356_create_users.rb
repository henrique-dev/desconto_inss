class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.string :birth_date
      t.decimal :wage
      t.decimal :deduction, default: 0.0

      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
