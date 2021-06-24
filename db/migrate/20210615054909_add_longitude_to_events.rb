class AddLongitudeToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :longitude, :string
  end
end
