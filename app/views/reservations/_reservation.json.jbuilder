json.extract! reservation, :id, :party_size, :time, :user_id, :table_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
