Rails.application.routes.draw do
  get 'draw_tags/new'

  get 'draw_tags/create'

  get 'draw_tags/destroy'

  get 'draw_tags/show'

  get 'draw_tags/edit'

  get 'tags/show'

  get 'tags/new'
  
  #get 'tags/new/:id', to: 'tags#new'
  
  

  get 'tags/create'

  get 'tags/destroy'

  get 'tags/update'

  get 'tags/show'

  get 'tags/new'

  get 'tags/create'

  get 'tags/destroy'

  get 'like_tags/show'

  get 'like_tags/new'

  get 'like_tags/create'

  get 'like_tags/destroy'

  get 'infos/new'
  
  

  get 'infos/show'

  get 'infos/destroy'
  
  

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
  
  #resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :snss
  resources :tags
  resources :like_tags
  resources :draw_tags
  resources :infos
  get 'users/:id/snss_edit', to: 'snss#edit', as: 'sns_edit'
  get 'users/:id/tags_edit', to: 'tags#new', as: 'tag_edit'
  get 'users/:id/infos_edit', to: 'infos#new', as: 'info_edit'
  

  #セッションを保持するsessionsというモデルを操作するリセットフルなURLを作る
  #sessionsの作成と，セッションの作成，セッションの破棄の3種類だからこうなる
  resources :sessions, only: [:new, :create, :destroy]
  #micropostsを操作するためのURLもつくってちょ
  resources :microposts
  #フォローとフォロー削除を行うURMつくってちょ
  resources :relationships, only: [:create, :destroy]
  
end