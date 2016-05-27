class InfosController < ApplicationController
  def new
    @user = current_user
    @info = Info.new
    @infos = Info.where(user_id: current_user.id).order("created_at DESC")
  end

  def show
  end
  
  def create
    @info = Info.new(info_params)
    @info.user_id = current_user.id
    if @info.save
      flash[:success] = "#{@info.text}を登録しました！"
      redirect_to new_info_path
    else
      flash[:success] = "#{@info.text}のURLを登録できませんでした"
      redirect_to new_info_path
    end
  end

  def destroy
    #binding.pry
    if current_user==nil
      flash[:success] = "不正なアクセスです，ログインしてください"
      redirect_to root_path
      else
        Info.find_by(id: params["id"]).destroy
        redirect_to :action => "new", :id => current_user.id
    end
  end
  
  def info_params
    params.require(:info).permit(:text, :link, :user_id)
  end
end
