Rails.application.routes.draw do
  # 顧客用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 # ゲストログイン
devise_scope :user do
      post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
                  end

namespace :admin do
    root to: "homes#top"
    resources :users
    resources :grants do
    resources :grant_comments, only: [:destroy]
   end
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
   end

 scope module: :public do
    root to: "homes#top"
    get "search" => "searches#search"
      resources :users do
        collection do
          # 退会確認画面
          get  '/users/check' => 'users#check'
          # 論理削除用のルーティング
          patch  '/users/withdraw' => 'users#withdraw'
        end
      end
    resources :grants do
    resources :grant_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  end
end