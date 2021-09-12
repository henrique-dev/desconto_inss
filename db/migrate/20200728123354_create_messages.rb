class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :message      
      t.string :from
      t.boolean :from_client
      t.boolean :active
      t.references :message_manager, foreign_key: true
      t.timestamps
    end
  end
end
