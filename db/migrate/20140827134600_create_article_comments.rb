#encoding: utf-8
class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
    add_index :article_comments, :article_id
    add_index :article_comments, :user_id
  end
end