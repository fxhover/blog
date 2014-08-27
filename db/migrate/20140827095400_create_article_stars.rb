#encoding: utf-8
class CreateArticleStars < ActiveRecord::Migration
  def change
    create_table :article_stars do |t|
      t.integer :article_id
      t.integer :user_id
      t.timestamps
    end
    add_index :article_stars, [:article_id, :user_id]
  end
end