#encoding: utf-8
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :articles_count
      t.timestamps
    end
    add_index :categories, :articles_count
  end
end