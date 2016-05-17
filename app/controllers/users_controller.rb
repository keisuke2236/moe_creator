class UsersController < ApplicationController
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    #コントローラーから受け取った値user型をインスタンス変数に格納する
    @user = User.new(user_params)
    #ここのif分でprefixが呼ばれる
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
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
    #user_paramsの確認をしてみよう
    #userの変数にはなんと便利なことにupdateクラスとかいうのがついててめんどくさいことしなくておk！すごい
    #⬆️全くもってそんなことはなかった@message = Message.find(params[:id])みたいな感じでちゃんとほぞんしましょう　
    
    
    #ログイン中のユーザー情報のポインタを@userに入れて
    @user = User.find(current_user[:id])
    #ログイン中のユーザー情報を参照している@userに対して送られてきた値を入れれば完成
    @user.update(user_params)
    #表示する内容を準備して　リダイレクト
    flash[:info] = "#{user_params[:name]}さんの情報を修正しました"
    redirect_to edit_user_path(current_user)
    
  end
  
  
  #user_paramsが送られてきたときに処理されるはず
  private
  def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
