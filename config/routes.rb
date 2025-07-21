Rails.application.routes.draw do
  # API para consumo do frontend Next.js
  namespace :api do
    namespace :v1 do
      get 'marketing_campaigns/index'
      get 'marketing_campaigns/create'
      get 'quotes/create'
      get 'reviews/index'
      get 'reviews/create'
      resources :companies,  only: %i[index show]
      resources :categories, only: %i[index show]
      resources :products,   only: %i[index show]
      resources :quotes,     only: %i[create]
      resources :reviews,    only: %i[index create]
      resources :marketing_campaigns, only: %i[index create]
    end
  end

  # Admin users e ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Usuários Devise (front e API privada)
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  # Root para o painel administrativo
  root to: 'admin/dashboard#index'
end
