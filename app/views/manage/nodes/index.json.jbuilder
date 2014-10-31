json.array!(@manage_nodes) do |manage_node|
  json.extract! manage_node, :id, :name, :title, :remark, :sort, :pid
  json.children do 
    json.array!(manage_node.child) do |child|
        json.extract! child, :id, :name, :title, :remark, :sort, :pid
    end
  end
end
