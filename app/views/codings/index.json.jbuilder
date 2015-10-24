json.array!(@codings) do |coding|
  json.extract! coding, :id
  json.url coding_url(coding, format: :json)
end
