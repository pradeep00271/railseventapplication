class AddLatitudeToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :latitude, :string
  end
end
