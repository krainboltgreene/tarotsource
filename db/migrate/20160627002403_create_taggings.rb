class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings, id: :uuid do |table|
      table.uuid :subject_id, null: false
      table.string :subject_type, null: false
      table.uuid :tag_id, null: false, index: true

      table.foreign_key :tags

      table.index [:subject_id, :subject_type]
      table.index [:subject_id, :subject_type, :tag_id], unique: true
    end
  end
end
