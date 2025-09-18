class AddAddresToContacts < ActiveRecord::Migration[7.1]
  def change
    add_reference :contacts, :address, foreign_key: true
  end
end
