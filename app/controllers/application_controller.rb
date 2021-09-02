class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Graphiti::Rails::Responders

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :init_row_level_security

  protected
    def configure_permitted_parameters
      attributes = [:name, :username]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    end

    def init_row_level_security
      # Devise is always called in a state where the user is not authenticated yet
      return RLS.disable! if devise_controller?

      if current_tenant
        RLS.set_tenant current_user.tenant
      else
        raise 'ERROR: RLS not set up!'
      end
  end
end
