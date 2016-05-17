class MicropostsController < ApplicationController
  #ツイートを作るときにだけパラメーターチェックを行う（models/microposts のやつ140文字いないとか）
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "ツイートが完了しました"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    #このユーザーのツイート一覧から今回削除するidを探してそれを@micropostsに入れる
    @micropost = current_user.microposts.find_by(id: params[:id])
    #もしそのツイートが存在しない場合はroot_urlに飛ばす
    return redirect_to root_url if @micropost.nil?
    #あったならそれを削除
    @micropost.destroy
    #削除が完了した旨を伝える
    flash[:success] = "削除が完了しました"
    #リファラに対してリダイレクトとかできるんかーw
    redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end