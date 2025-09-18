class CreatePlaceType < ActiveRecord::Migration[7.1]
  def change
    create_table :place_types do |t|
      t.string :description
      t.string :avatar
      t.timestamps
    end
  end
end
