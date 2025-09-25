class CreateHazards < ActiveRecord::Migration[7.1]
  def change
    create_table :hazards do |t|
      t.string :code, null: false
      t.datetime :occurence
      t.string :type
      t.float :latitude
      t.float :longitude
      t.float :magnitude
      t.timestamps
    end
  end
end
