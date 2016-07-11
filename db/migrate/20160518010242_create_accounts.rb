class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |table|
      table.text :name, null: false
      table.text :email, null: false, index: {unique: true}
      table.text :avatar
      table.boolean :reader, default: false, null: false, index: trueb
      table.text :encrypted_password, null: false
      table.text :reset_password_token, index: true
      table.datetime :reset_password_sent_at
      table.datetime :remember_created_at
      table.text :confirmation_token, index: true
      table.datetime :confirmed_at
      table.datetime :confirmation_sent_at
      table.text :unconfirmed_email, index: true

      table.timestamps null: false, index: true
    end
  end
end
