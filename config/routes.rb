Rails.application.routes.draw do
  namespace :api, defaults: { format: :jsonapi } do
    namespace :v1 do
      mount VandalUi::Engine, at: '/vandal'

      resources :users
      resources :roles
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
    registrations:      'overrides/registrations',
    sessions:           'overrides/sessions'
  }
end
