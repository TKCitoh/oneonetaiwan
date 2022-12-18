Rails.application.routes.draw do

 # ユーザー
 # URL /customers/sign_in ...
 # 顧客はパスワードの変更ができるようにするため、skipの設定はしない
 devise_for :end_users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }

 #URL変更せずコントローラーのみnamespace使用
 scope module: :public do
   root to: "homes#top"#ルートパス"/""
   get 'about' => 'public/homes#about'

   get 'end_users/my_page' => 'end_users#show'
   get 'end_users/information/edit' => 'end_users#edit'
   patch 'end_users/information' => 'end_users#update'
   get 'end_users/unsubscribe'
   patch 'end_users/withdraw'
   get 'end_users/likes'

   resources :likes, only: [:create, :destroy]

   resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      collection do
        get 'search'
      end
   end

   resources :comments, only: [:create, :destroy]

 end

 # 管理者
 # URL /admin/sign_in ...
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
 }

 namespace :admin do
   resources :end_users, only: [:index, :show, :edit, :update]
   resources :comments,  only: [:index, :destroy]
 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
