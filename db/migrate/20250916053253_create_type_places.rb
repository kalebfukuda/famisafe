class CreateTypePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :type_places do |t|
      t.string :description
      t.string :avatar
      t.timestamps
    end
  end
end
