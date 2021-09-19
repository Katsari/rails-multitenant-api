Rails.application.reloader.to_prepare do
  RLS.configure do |config|
    config.tenant_class = Tenant
    config.user_class = User
    config.tenant_fk = :tenant_id
    config.policy_dir = 'db/policies'
  end
end
