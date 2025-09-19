class AddAvatarToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :avatar, :string
  end
end
