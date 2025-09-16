class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :district
      t.string :block
      t.string :building_name
      t.string :number
      t.references :contacts, null: false, foreign_key: true
      t.timestamps
    end
  end
end
