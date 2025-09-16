class CreateContactsLists < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts_lists do |t|
      t.references :users, null: false, foreign_key: true
      t.references :contacts, null: false, foreign_key: true
      t.timestamps
    end
  end
end
