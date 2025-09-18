class CreateListAdresses < ActiveRecord::Migration[7.1]
  def change
    create_table :list_adresses do |t|
      t.references :address, null: false
      t.references :contact, null: false
      t.timestamps
    end
  end
end
