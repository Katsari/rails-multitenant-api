RLS.policies_for :users do
  using_tenant
  check_tenant
end
