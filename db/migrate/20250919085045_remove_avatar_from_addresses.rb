class RemoveAvatarFromAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :avatar, :string
  end
end
