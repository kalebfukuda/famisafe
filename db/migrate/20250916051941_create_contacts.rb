class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :telephone
      t.string :email
      t.string :relationship
      t.float  :latitude
      t.float  :longitude
      t.string :avatar
      t.references :family, null: false
      t.timestamps
    end
  end
end
