#encoding: utf-8
class CreateBlogInfo < ActiveRecord::Migration
  def change
    create_table :blog_info do |t|
      t.string :name
      t.string :blog_title
      t.string :email
      t.text :description
    end
  end
end