json.array!(@competitors) do |competitor|
  json.extract! competitor, :id
  json.url competitor_url(competitor, format: :json)
end
