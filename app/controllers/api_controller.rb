class APIController < ApplicationController
  include Graphiti::Rails::Responders

  set_current_tenant_through_filter
  before_action :authenticate_user!
  before_action :init_row_level_security
  before_action :set_tenant

  register_exception CanCan::AccessDenied,
    status: 403,
    title: 'You are not authorized to perform this action',
    message: ->(error) { 'Invalid action' }

  protected
    def init_row_level_security
      if current_user
        RLS.set_tenant current_user.tenant
      else
        raise 'ERROR: RLS not set up!'
      end
    end

    def set_tenant
      set_current_tenant(RLS.current_tenant)
    end
end
