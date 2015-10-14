class AddIndexToEmail < ActiveRecord::Migration
  def change
  	#确保数据库邮箱唯一性
  	add_index :users, :email, unique: true
  end
end
