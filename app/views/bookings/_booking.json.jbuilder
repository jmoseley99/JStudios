json.extract! booking, :id, :Date, :Time, :RoomNo, :created_at, :updated_at
json.url booking_url(booking, format: :json)
