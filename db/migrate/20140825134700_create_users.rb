#encoding: utf-8
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.boolean :admin
      t.datetime :last_login_time
      t.datetime :last_reply_time
      t.timestamps
    end
  end
end