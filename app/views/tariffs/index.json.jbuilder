json.array!(@tariffs) do |tariff|
  json.extract! tariff, :id
  json.url tariff_url(tariff, format: :json)
end
