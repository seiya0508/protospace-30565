Rails.application.routes.draw do
  devise_for :users
# ルートパスへのアクセスがあったら、prototypes_controllerのindexアクションが呼び出される
  root to: "prototypes#index"
   # 画面へ遷移（画面移動）するために、newアクションの設定
   # form_withのリクエストに対応するcreateアクションの設定
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
  resources :comments, only: :create
  end
  resources :users, only: :show
end

