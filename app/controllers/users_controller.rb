class UsersController < ApplicationController
  before_action :user_check, only: [:edit, :update]
  
  def show
    if logged_in?
      @user = User.find(params[:id])
      @snss = Sns.where(user_id:current_user.id)
      @infos = Info.where(user_id: @user.id).order("created_at DESC")
      @micropost = current_user.microposts.build
      @microposts = Micropost.where(touser_id: @user.id).order("created_at DESC")
      #binding.pry
      @tags = @user.draw_tags
    else
      redirect_to login_url
    end
  end
  
  def select
  end
  
  def new
    @user = User.new
  end
  
  
  def fun_new
    @user = User.new
    @user.creator = false;
  end
  
  def create
    if request.referer.include?("fun")
      @user = User.new(user_params)
      @user.creator = false
      if @user.save
        flash[:success] = "#{@user.name}さんの会員登録が完了しました，ログインしてください"
        redirect_to login_url
      else
        flash[:success] = "すでに会員登録されているか，不正な値が入力されています"
        redirect_to fun_new_url
      end
    else
      #コントローラーから受け取った値user型をインスタンス変数に格納する
      @user = User.new(user_params)
      @user.creator = true
      #ここのif分でprefixが呼ばれる
      if @user.save
        flash[:success] = "#{@user.name}さんの会員登録が完了しました，ログインしてください"
        redirect_to login_url
      else
        flash[:success] = "すでに会員登録されているか，不正な値が入力されています"
        redirect_to new_user_path
      end
    end
    
  end
  
  def edit
    if current_user==nil || params["id"]!=current_user.id.to_s
      redirect_to root_path 
    else
      @user = current_user
      @sns = Sns.new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "基本情報を更新しました"
      redirect_to @user
    else 
      render 'edit'
    end
  end
  
  #フォローしているユーザー一覧を表示するページ
  def following
    @user = User.find(params[:id])
    #binding.pry
    @users = @user.following_users
  end
  
  #フォローされているユーザー一覧を表示するページ
  def followers
    @user = User.find(params[:id])
    #binding.pry
    @users = @user.follower_users
  end

  
  #user_paramsが送られてきたときに処理されるはず，カラムを追加したらこれもやろう
  private
  def user_params
    #binding.pry
    params.require(:user).permit(:name, :avatar , :picture, :bg , :area ,:age ,:email ,:hp, :password, :password_confirmation)
  end
  
  def user_check
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end
  
end
