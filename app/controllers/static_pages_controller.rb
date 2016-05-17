class StaticPagesController < ApplicationController
  def home
    #ifを最後に付けることでこの文を実行するかはif文の結果しだいになるとかいう設定（）
    @micropost = current_user.microposts.build if logged_in?
  end
end