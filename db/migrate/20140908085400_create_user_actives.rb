#encoding: utf-8
class CreateUserActives < ActiveRecord::Migration
  def change
    create_table :user_actives do |t|
      t.integer :user_id
      t.string :type_name
      t.string :token
      t.boolean :used
      t.timestamps
    end
  end
end