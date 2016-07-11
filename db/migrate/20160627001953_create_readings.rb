class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings, id: :uuid do |table|
      table.text :name, null: false
      table.text :description, null: false
      table.monetize :price, null: false, default: 500, index: true
      table.text :photo
      table.uuid :account_id, null: false, index: true
      table.uuid :store_id, null: false, index: true

      table.timestamps null: false, index: true

      table.foreign_key :accounts
      table.foreign_key :stores

      table.index [:account_id, :store_id], unique: true
    end
  end
end
