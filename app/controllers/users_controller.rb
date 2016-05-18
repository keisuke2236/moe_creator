class UsersController < ApplicationController
  before_action :user_check, only: [:edit, :update]
  
  def show # 追加
    if logged_in?
      @user = User.find(params[:id])
      #ツイート一覧にはそのユーザーのツイート一覧を作成日順降順で並べたものを入れる
      @microposts = @user.microposts.order(created_at: :desc)
    else
      redirect_to login_url
    end
  end
  
  
  def new
    @user = User.new
  end
  
  def create
    #binding.pry
    #コントローラーから受け取った値user型をインスタンス変数に格納する
    @user = User.new(user_params)
    #ここのif分でprefixが呼ばれる
    if @user.save
      flash[:success] = "会員登録が完了しました，ログインしてください"
      redirect_to @user

      #これと同じ動作をする
      #redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end
  end
  
  #フォローしているユーザー一覧を表示するページ
  def following
    @user = User.find(params[:id])
    #binding.pry
    @users = current_user.following_users
  end
  
  #フォローされているユーザー一覧を表示するページ
  def followers
    @user = User.find(params[:id])
    #binding.pry
    @users = @user.following_relationships
    @microposts = @user.microposts.order(created_at: :desc)
  end

  
  #user_paramsが送られてきたときに処理されるはず，カラムを追加したらこれもやろう
  private
  def user_params
        params.require(:user).permit(:name, :area ,:age ,:email ,:hp, :password, :password_confirmation)
  end
  
  def user_check
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end
  
end
