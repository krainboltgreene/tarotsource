class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores, id: :uuid do |table|
      table.text :name, null: false, index: {unique: true}
      table.text :description, null: false
      table.text :photo
      table.uuid :account_id, null: false, index: true

      table.timestamps null: false, index: true

      table.foreign_key :accounts
    end
  end
end
