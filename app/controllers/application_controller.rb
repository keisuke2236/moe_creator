class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #全てのクラスでログイン情報を利用できるようにする
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
end