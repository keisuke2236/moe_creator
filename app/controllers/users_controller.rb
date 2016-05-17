class UsersController < ApplicationController
  

  def show # 追加
    if logged_in?
      @user = User.find(current_user)
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
    #binding.pry
    #user_paramsの確認をしてみよう
    #ログイン中のユーザー情報のポインタを@userに入れて
    @user = User.find(current_user[:id])
    #ログイン中のユーザー情報を参照している@userに対して送られてきた値を入れれば完成
    @user.update(user_params)
    #表示する内容を準備して　リダイレクト
    flash[:info] = "#{user_params[:name]}さんの情報を修正しました"
    redirect_to edit_user_path(current_user)
  end

  
  #user_paramsが送られてきたときに処理されるはず，カラムを追加したらこれもやろう
  private
  def user_params
        params.require(:user).permit(:name, :area ,:age ,:email, :password, :password_confirmation)
  end

end
