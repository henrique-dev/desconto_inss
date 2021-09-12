Rails.application.routes.draw do  

  devise_for :admins, at: 'admins/auth'
  devise_for :users, at: 'users/auth'

  mount_devise_token_auth_for 'Patient', at: 'patients/auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }

  mount_devise_token_auth_for 'Medic', at: 'medics/auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }  

  scope module: 'admin' do
    resources :clinic_profiles
    resources :clinics
    resources :addresses  
    resources :schedulings do
      collection do
        get :medics
      end
    end
    resources :medic_profiles
    resources :patient_profiles
    resources :specialities  
    resources :patient_accounts
    resources :account_specialities
    resources :medic_work_schedulings
    resources :medic_specialities

    resources :messages

    root to: "home#index"
    get 'home/index'
  end

  namespace :user do

    namespace :sinan do

      resources :diseases, only: :index do
        collection do
          get :get_years, :get_data
        end  
      end

    end

    get 'home/index'
    root to: "home#index"    
  end

  namespace :medic do

    resources :register do
      collection do        
        post :check_telephone, :check_token, :confirm_token
      end  
    end

    resources :schedulings do
      collection do
        post :finalize
        get :days, :day
      end
      member do
        get :patient_profile, :patient_files
      end
    end
    
    resources :medic_evaluations
    resources :medic_profiles do
      collection do
        get :my_profile
        post :update_profile_file
        patch :update_profile
      end
    end
    resources :specialities  
    resources :patient_accounts
    resources :account_specialities
    resources :medic_work_schedulings
  end

  namespace :patient do
    
    resources :register do
      collection do        
        post :check_telephone, :check_token, :confirm_token
      end  
    end

    resources :medic_evaluations
    resources :schedulings
    resources :medic_profiles
    resources :patient_profiles do
      collection do
        get :my_profile
        patch :update_profile
      end
    end
    resources :patient_files do
      collection do
        post :update_profile_file
      end
    end
    resources :specialities
    resources :patient_accounts
    resources :account_specialities
    resources :medic_work_schedulings do
      collection do
        get :get_unavailable_days, :get_schedules_on_day, :confirm_schedule_on_day, :check_scheduling_priv
        post :make_scheduling
      end      
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  get 'home/index'
  #get 'inicio', to: 'home/admin#index'
  #root to: 'home/admin#index'
end

# belongs_to :profile, class_name: "PatientProfile", optional: true, foreign_key: "patient_profile_id"  