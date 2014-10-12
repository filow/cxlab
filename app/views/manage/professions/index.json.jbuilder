json.array!(@manage_professions) do |manage_profession|
  json.extract! manage_profession, :id, :name
  json.url manage_profession_url(manage_profession, format: :json)
end
