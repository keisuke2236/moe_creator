class MicropostsController < ApplicationController
  #ツイートを作るときにだけパラメーターチェックを行う（models/microposts のやつ140文字いないとか）
  before_action :logged_in_user, only: [:create]

  def create
    
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.touser_id = params["touser_id"].to_i
    if @micropost.save
      flash[:success] = "#{User.find_by(id:params["touser_id"]).name}さんの情報を提供しました"
      redirect_to request.referrer
    else
      #staticページに行く前にあらかじめロードしておくと処理が軽い
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) # この行を追加
      render 'static_pages/home'
    end
  end

  def destroy
    #binding.pry
    #このユーザーのツイート一覧から今回削除するidを探してそれを@micropostsに入れる
    @micropost= Micropost.find_by(id:params["id"])
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
    params.require(:micropost).permit(:content,:user_id,:touser_id)
  end
end