json.array!(@photos) do |photo|
  json.extract! photo, :id, :title, :description, :album_id, :capture_time, :longitude, :latitude
  json.url photo_url(photo, format: :json)
end
