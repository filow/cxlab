json.extract! @manage_admin, :id, :uid, :nickname, :email, :desc, :is_enabled, :created_at, :updated_at
json.roles    @manage_admin.roles
json.privilege do
    json.array!(@manage_nodes) do |node|
        json.extract! node,:id,:name,:title
        json.child do
            json.array!(node.child) do |node_child|
                json.extract! node_child,:id,:name,:title,:remark
            end
        end 
    end
end
