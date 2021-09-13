Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :admins, at: 'admins/auth'

  mount Sidekiq::Web => '/sidekiq'

  scope module: 'admin' do
    resources :users do
      member do
        post :calculate_deduction
      end
      collection do
        post :calculate_deduction
      end
    end

    resources :reports do
      collection do
        get :general
      end
    end

    root to: 'home#index'
    get 'home/index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  get 'home/index'
  # get 'inicio', to: 'home/admin#index'
  # root to: 'home/admin#index'
end

# belongs_to :profile, class_name: "PatientProfile", optional: true, foreign_key: "patient_profile_id"
