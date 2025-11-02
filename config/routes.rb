Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], 
  controllers: {sessions: 'admin/sessions'}
  

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'

    resources :members, only: [:index, :show, :destroy] 
  end

  scope module: :public do
    
    devise_for :members
    root to: "homes#top"
    get 'homes/about' => "homes#about", as: :about

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    
    resources :members, only: [:show, :edit, :update]
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
