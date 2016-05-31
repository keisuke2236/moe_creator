class SessionsController < ApplicationController
  def new
  end
  
  def create
    #クラス変数userにUserモデルから今回入力されたセッションとメールアドレスで検索をかける（全部小文字にする）
    @user = User.find_by(email: params[:session][:email].downcase)
    #ユーザーが見つかったらauthenticateでパスワードが正しいかをチェックします
    if @user && @user.authenticate(params[:session][:password])
      #セッション中のユーザーにこのユーザーIDを追加して
      session[:user_id] = @user.id
      #後で表示できるようにflash変数に文字列を入れておきます　:infoを紐付けることで情報として表示（スタイルが）
      flash[:info] = "#{@user.name}さんでログインしています"
      #binding.pry
      if @user.creator
        #そのユーザーのページへ移動する
        redirect_to @user
      else
        redirect_to root_path
      end
    else
      flash[:danger] = "メアドかパスワードが間違っています"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
