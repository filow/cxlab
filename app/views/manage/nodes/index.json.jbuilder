json.array!(@manage_nodes) do |manage_node|
  json.extract! manage_node, :id, :name, :title, :remark, :extra_data, :sort, :pid
  json.url manage_node_url(manage_node, format: :json)
end
