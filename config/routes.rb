Rails.application.routes.draw do
# ====================== 管理者側 (Admin) のルーティング ======================
  # Devise for Admin (registrations, passwordはスキップ)
  devise_for :admin, skip: [:registrations, :password], 
  controllers: {sessions: 'admin/sessions'}
  
  # Admin名前空間内のルーティング
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    # メンバーの削除のみを許可
    resources :members, only: [:index, :show, :destroy] 
  end

  # ====================== 公開側 (Public) のルーティング ======================
  scope module: :public do
    
    # 【1. Deviseをresourcesより先に定義】
    devise_for :members
    
    # Top/Aboutページ
    root to: "homes#top"
    get 'homes/about' => "homes#about", as: :about

    # 投稿とコメント
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    
    # 【2. Deviseと重複するルーティングを除外】
    # showアクション（プロフィールページ）などに絞るのが一般的
    resources :members, only: [:show, :edit, :update]
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
