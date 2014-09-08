#encoding: utf-8
class AddActivationColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation, :boolean
  end
end