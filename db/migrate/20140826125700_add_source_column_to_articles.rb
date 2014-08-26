#encoding: utf-8
class AddSourceColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :source, :string
  end
end