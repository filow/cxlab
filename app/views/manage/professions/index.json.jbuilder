json.array!(@manage_professions) do |manage_profession|
  json.extract! manage_profession, :id, :name, :pid
  json.children do 
    json.array!(manage_profession.child) do |child|
        json.extract! child, :id, :name, :pid
    end
  end
end
