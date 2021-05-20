json.extract! event, :id, :event_name, :event_description, :start_date, :end_date, :city, :created_at, :updated_at
json.url event_url(event, format: :json)
