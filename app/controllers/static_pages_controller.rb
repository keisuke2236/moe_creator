class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items(params[:page]).includes(:user).order(created_at: :desc)
    end
    #ifを最後に付けることでこの文を実行するかはif文の結果しだいになるとかいう設定（）
    #不要になりました
    #@micropost = current_user.microposts.build if logged_in?
  end
end