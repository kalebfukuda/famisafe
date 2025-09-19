class AddContactToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :contact, null: true, foreign_key: true
  end
end
