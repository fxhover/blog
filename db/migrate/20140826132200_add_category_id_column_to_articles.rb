#encoding: utf-8
class AddCategoryIdColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :category_id, :integer
  end
end