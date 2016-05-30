class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      
      #自分に関係ある情報提供一覧
      @feed_items = current_user.feed_items(params[:page]).includes(:user).order(created_at: :desc)
      #フォロー絵師の最新ニュースフィード
      @infos = current_user.get_news(params[:page]).order(created_at: :desc)
      
      #@microposts = current_user.following_user
    end
    #ifを最後に付けることでこの文を実行するかはif文の結果しだいになるとかいう設定（）
  end
end