Rails.application.reloader.to_prepare do
  RLS.configure do |config|
    config.tenant_class = Tenant
    config.tenant_fk = :tenant_id
    config.policy_dir = 'db/policies'
  end
end
