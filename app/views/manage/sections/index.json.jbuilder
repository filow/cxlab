json.array!(@manage_sections) do |manage_section|
  json.extract! manage_section, :id, :name, :start_time, :end_time
  json.url manage_section_url(manage_section, format: :json)
end
