json.array!(@risks) do |risk|
  json.extract! risk, :id
  json.url risk_url(risk, format: :json)
end
