module Requests
  module AuthHelpers
    module Extensions
      def sign_in(user)
        let(:auth_helpers_auth_token) {
          self.public_send(user).create_new_auth_token
        }
      end
    end

    module Includables
      HTTP_HELPERS_TO_OVERRIDE =
        [:get, :post, :patch, :put, :delete].freeze
      HTTP_HELPERS_TO_OVERRIDE.each do |helper|
        define_method(helper) do |path, **args|
          add_auth_headers(args)
          args == {} ? super(path) : super(path, **args)
        end
      end

      private
        def add_auth_headers(args)
          return unless defined? auth_helpers_auth_token
          args[:headers] ||= {}
          args[:headers].merge!(auth_helpers_auth_token)
        end
    end
  end
end
