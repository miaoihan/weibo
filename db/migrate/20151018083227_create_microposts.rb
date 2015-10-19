class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    # => 按照发布时间的倒序查询某个用户发布的所有微博
    add_index :microposts, [ :user_id, :created_at ]
  end
end
