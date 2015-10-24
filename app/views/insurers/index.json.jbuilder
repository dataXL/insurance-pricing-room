json.array!(@insurers) do |insurer|
  json.extract! insurer, :id
  json.url insurer_url(insurer, format: :json)
end
