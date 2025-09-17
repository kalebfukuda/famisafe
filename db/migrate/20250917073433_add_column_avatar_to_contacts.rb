class AddColumnAvatarToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :avatar, :string
  end
end
