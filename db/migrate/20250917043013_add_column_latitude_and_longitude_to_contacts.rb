class AddColumnLatitudeAndLongitudeToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :latitude, :float
    add_column :contacts, :longitude, :float
  end
end
