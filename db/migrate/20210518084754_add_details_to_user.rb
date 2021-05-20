class AddDetailsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :phone_no, :string
    add_column :users, :role, :string
  end
end
