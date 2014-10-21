json.array!(@manage_contests) do |manage_contest|
  json.extract! manage_contest, :id, :name, :description, :summary, :level, :organizer
  json.url manage_contest_url(manage_contest, format: :json)
end
