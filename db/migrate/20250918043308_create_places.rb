class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :description
      t.references :family, null: false
      t.references :address, null: false
      t.references :place_type, null: false
      t.timestamps
    end
  end
end
