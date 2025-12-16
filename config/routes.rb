Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], 
  controllers: {sessions: 'admin/sessions'}
  

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'

    resources :members, only: [:index, :show, :destroy] 
    resources :groups, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  scope module: :public do
    
    devise_for :members

    post "members/guest_sign_in", to: "guest_sessions#create", as: :guest_sign_in

    root to: "homes#top"
    get 'homes/about' => "homes#about", as: :about

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    
    resources :members, only: [:show, :edit, :update]

    resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    resource :group_members, only: [:create, :destroy]
      member do
        get 'applications'    
        patch 'approve_application' 
        patch 'reject_application' 
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
