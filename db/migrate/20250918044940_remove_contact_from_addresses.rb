class RemoveContactFromAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_reference :addresses, :contacts, foreign_key: true
  end
end
