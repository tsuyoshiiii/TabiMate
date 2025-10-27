Rails.application.routes.draw do
  get 'searches/search'
  devise_for :members
  root to: "homes#top"
  get 'homes/about' => "homes#about", as: :about
  resources :members
  resources :posts 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
