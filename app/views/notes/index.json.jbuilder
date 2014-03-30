json.array!(@notes) do |note|
  json.extract! note, :id, :message, :created_at, :sent_at
  json.url note_url(note, format: :json)
end
