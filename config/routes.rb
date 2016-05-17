Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'sessions/new'
  get 'edit' , to: 'users#edit'
  #サインアップはnewメソッドで処理
  get 'signup',  to: 'users#new'
  #ログインはnewメソッドで同じく処理　した後　view/sessions/new.html.erb　で表示
  get 'login' , to: 'sessions#new'
  #post通信で loginが飛んできたら　セッションクラスのクリエイトで処理 view/sessions/create.html.erbで処理
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  #セッションを保持するsessionsというモデルを操作するリセットフルなURLを作る
  #sessionsの作成と，セッションの作成，セッションの破棄の3種類だからこうなる
  resources :sessions, only: [:new, :create, :destroy]
end