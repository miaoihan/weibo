class AddIndexToEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true	# => 确保数据库邮箱唯一性
  end
end
