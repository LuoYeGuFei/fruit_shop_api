class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :receiver
      t.string :tel
      t.text :addr
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
