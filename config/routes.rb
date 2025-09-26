Rails.application.routes.draw do
  get 'members/show'
  get 'members/edit'
  devise_for :members
  root to: "homes#top"
  get 'homes/about' => "homes#about", as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
