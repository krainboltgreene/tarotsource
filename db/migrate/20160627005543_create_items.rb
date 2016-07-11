class CreateItems < ActiveRecord::Migration
  def change
    create_table :items, id: :uuid do |table|
      table.monetize :subtotal
      table.monetize :discount
      table.monetize :total
      table.uuid :cart_id, null: false, index: true
      table.uuid :subject_id, null: false
      table.string :subject_type, null: false

      table.timestamps null: false

      table.foreign_key :carts

      table.index [:subject_id, :subject_type]
      table.index [:cart_id, :subject_id, :subject_type]
    end
  end
end
