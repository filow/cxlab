json.extract! @manage_admin, :id, :uid, :nickname, :email, :desc, :is_enabled, :created_at, :updated_at
json.roles    @manage_admin.roles
