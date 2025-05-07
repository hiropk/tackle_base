Rails.application.routes.draw do
  resources :users do
    resource :profile, only: [ :show, :edit, :update ]
    collection do
      get :manual_activation
    end
  end
  resources :logs
  resources :tackles
  resources :reels
  resources :leaders
  resources :lines
  resources :rods
  get "homes/index"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "homes#index"

  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/activate/:token", to: "users#activate", as: "activate_user"
  if Rails.env.development?
    # LetterOpenerWebのエンジンをマウント
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
