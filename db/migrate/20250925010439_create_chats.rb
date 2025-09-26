class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :title
      t.references :user, null: false
      t.timestamps
    end
  end
end
