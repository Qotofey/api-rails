Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :users, only: %i[index show create update destroy]
    namespace :users do
      resources :sign_in, only: %i[create]
      resources :sign_up, only: %i[create]
      resources :refresh_token, only: %i[create]

      namespace :password do
        resources :recover, only: %i[create]
        resources :send_recovery_code, only: %i[create]
      end
      namespace :email do
        resources :confirm, only: %i[create]
        resources :send_confirmation_code, only: %i[create]
        end
      namespace :phone do
        resources :confirm, only: %i[create]
        resources :send_confirmation_code, only: %i[create]
      end
    end
  end
end
