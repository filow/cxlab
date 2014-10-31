json.array!(@manage_competes) do |manage_compete|
  json.extract! manage_compete, :id, :start_time, :end_time, :admin_id, :contest_id
  json.url manage_compete_url(manage_compete, format: :json)
end
