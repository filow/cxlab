json.array!(@manage_admins) do |manage_admin|
  json.extract! manage_admin, :id, :uid, :nickname, :email, :desc, :is_enabled
  json.roles    manage_admin.roles
  json.url manage_admin_url(manage_admin, format: :json)
end
