class CreateCookbookUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login, :string
      t.column :email, :string
      t.column :hashed_password, :string
      t.column :salt, :string
      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end
