json.extract! room, :id, :RoomID, :Description, :created_at, :updated_at
json.url room_url(room, format: :json)
