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
      t.string :description
      t.references :type_place, null: false
      t.timestamps
    end
  end
end
