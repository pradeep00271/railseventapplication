class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.text :event_description
      t.date :start_date
      t.date :end_date
      t.string :city

      t.timestamps
    end
  end
end
