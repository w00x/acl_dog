json.array!(@acls) do |acl|
  json.extract! acl, :id, :action, :controller, :role_id
  json.url acl_url(acl, format: :json)
end
