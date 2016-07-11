class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, id: :uuid do |table|
      table.string :name, null: false, index: {unique: true}

      table.timestamps null: false, index: true
    end
  end
end
