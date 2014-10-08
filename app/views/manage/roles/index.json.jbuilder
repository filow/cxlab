json.array!(@manage_roles) do |manage_role|
  json.extract! manage_role, :id, :name, :is_enabled, :remark
  json.url manage_role_url(manage_role, format: :json)
  json.value do
	  json.extract! manage_role, :id, :name, :is_enabled, :remark
	  json.url manage_role_url(manage_role, format: :json)  	
  end
end
