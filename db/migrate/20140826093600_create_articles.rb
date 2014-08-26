#encoding: utf-8
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.string :tags
      t.text :content
      t.integer :view_count
      t.integer :star_count
      t.integer :comments_count
      t.timestamps
    end
    add_index :articles, :user_id
    add_index :articles, :title
    add_index :articles, :view_count
    add_index :articles, :star_count
    add_index :articles, :comments_count
    add_index :articles, :created_at
  end
end