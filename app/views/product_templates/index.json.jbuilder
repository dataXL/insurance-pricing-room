json.array!(@product_templates) do |product_template|
  json.extract! product_template, :id
  json.url product_template_url(product_template, format: :json)
end
