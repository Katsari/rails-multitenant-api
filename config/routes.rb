Rails.application.routes.draw do
  scope path: V1::APIResource.endpoint_namespace, defaults: { format: :jsonapi } do
    mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
    mount VandalUi::Engine, at: '/vandal'

    resources :tenants
  end
end
