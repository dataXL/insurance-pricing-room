json.array!(@coefficients) do |coefficient|
  json.extract! coefficient, :id
  json.url coefficient_url(coefficient, format: :json)
end
