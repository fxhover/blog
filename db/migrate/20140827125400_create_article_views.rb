#encoding: utf-8
class CreateArticleViews < ActiveRecord::Migration
  def change
    create_table :article_views do |t|
      t.integer :article_id
      t.integer :user_id
      t.string :ip
      t.text :param_string
      t.timestamps
    end
    add_index :article_views, [:article_id, :ip, :created_at]
  end
end