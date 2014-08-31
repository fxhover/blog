#encoding: utf-8
class AddNicknameAndAvatarColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nick_name, :string
    add_column :users, :avatar, :string
    add_index :users, :nick_name
  end
end