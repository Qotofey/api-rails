Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :users, only: %i[index show create update destroy]
    namespace :users do
      resources :sign_in, only: %i[create]
    end
    resources :roles, only: :index
  end
end
