Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], 
  controllers: {sessions: 'admin/sessions'}
    devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
 
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
  end
  
  devise_for :members
  root to: "homes#top"
  get 'homes/about' => "homes#about", as: :about
  resources :members
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
