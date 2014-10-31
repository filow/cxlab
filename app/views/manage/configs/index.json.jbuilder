json.array!(@manage_configs) do |manage_config|
  json.extract! manage_config, :id, :key, :value, :field_type
  json.url manage_config_url(manage_config, format: :json)
end
