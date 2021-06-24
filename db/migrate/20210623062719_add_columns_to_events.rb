class AddColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :street_address, :string
    add_column :events, :city1, :string
    add_column :events, :state, :string
    add_column :events, :country, :string
    add_column :events, :zip_code, :string
  end
end
