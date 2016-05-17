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
  
  
  #user_paramsが送られてきたときに処理されるはず
  private
  def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
