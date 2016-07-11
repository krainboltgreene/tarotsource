class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts, id: :uuid do |table|
      table.monetize :tax, null: false
      table.monetize :discount, null: false
      table.monetize :total, null: false
      table.datetime :charged_at, index: true
      table.uuid :account_id, null: false, index: true

      table.timestamps null: false, index: true

      table.foreign_key :accounts
    end
  end
end
