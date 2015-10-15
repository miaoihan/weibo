class AddRememberDigestToUsers < ActiveRecord::Migration
  def change
    #记忆摘要
    add_column :users, :remember_digest, :string
  end
end
