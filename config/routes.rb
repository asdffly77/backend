Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/staff', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|zh-CN/ do
    root to: 'home#index'

    scope '/console_platform' do
      controller "trestle/auth/sessions" do
        # if Trestle.config.auth.enable_login
        get  'login'  => :new, as: :login
        post 'login'  => :create
        # end

        # if Trestle.config.auth.enable_logout
        get 'logout' => :destroy, as: :logout
        # end
      end
    end


    resources :user_agreement, only: [:index]
    resources :search, only: [:index]
    resources :chats, only: %w(index show)
    resources :translate, only: %w(index)
    resources :companies, only: %w(index show edit update create) do
      get :autocomplete_company_classify_name, :on => :collection
      collection do
        get :manufacture
      end
    end
    resources :fashion_weeks, only: %w(index)
    resources :design_activities, only: %w(index)
    resources :log_out, only: %w(index)
    resources :recover_password, only: %w(index create) do
      collection do
        post 'send_code'
      end
    end
    resources :lives, only: %w(index show update) do
      member do
        get 'lives'
        get 'history'
        get 'cases'
        get 'guests'
        get 'comments'
        post 'comments', to: 'lives#comment_create'
        get 'barrages'
        post 'barrages', to: 'lives#barrage_create'
      end
    end
    resources :news, only: %w(index show edit update)
    resources :sessions, only: %w(new create)
    resources :sign_up, only: %w(index create) do
      collection do
        post 'send_code'
      end
    end
    resources :demands, only: %w(index create)
    resources :images, only: %w(create)
    resources :about, only: %w(index)
    resources :cases, only: %w(show edit update create destroy)
    resources :dashboard, only: %w(index) do
      collection do
        get 'password'
        post 'password', to: "dashboard#change_password"
        get 'company'
        get 'cases'
        get 'cases_create'
        get 'lives'
        get 'translate'
        get 'demands'
        get 'user_demands'
        get 'demands/:id', to: "dashboard#demand_show", as: 'demand_show'
        post 'change_password'
      end
      member do
        get 'cases_edit'
      end
    end
    post 'users', to: "dashboard#avatar"
  end
  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:create, :index]
  #     resources :sessions, only: [:create] do
  #       collection do
  #         delete '/', :to => 'sessions#destroy'
  #       end
  #     end
  #   end
  # end
end
