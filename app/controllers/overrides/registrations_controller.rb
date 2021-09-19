module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    # Override DeviseTokenAuth::RegistrationsController methods here...
    # See https://github.com/lynndylanhurley/devise_token_auth/blob/8a33d25deaedb4809b219e557e82ec7ec61bf940/app/controllers/devise_token_auth/registrations_controller.rb
    # And https://devise-token-auth.gitbook.io/devise-token-auth/usage/overrides

    prepend_before_action :disable_row_level_security

    protected
      def disable_row_level_security
        RLS.disable!
      end
  end
end
