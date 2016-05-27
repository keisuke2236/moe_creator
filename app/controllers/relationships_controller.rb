class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    def create
        #User一覧の中からフォローしたいと送られてきたparams[:follow_]id]をさがして入れる
        @user = User.find(params[:followed_id])
        #現在ログインしているユーザーのフォローメソッド（Userモデルに記述してある）を使ってフォロー
        current_user.follow(@user)
    end
    
    def destroy
        if request.referrer.include?("follow")
            #binding.pry
            @user = User.find_by(id: current_user.following_relationships.find(request[:idendification]).followed_id)
            current_user.unfollow(@user)
            redirect_to request.referrer
        else
            #binding.pry
            #削除したいユーザーのidがparamsに入ってるのでフォロー一覧から検索して取り出す
            @user = current_user.following_relationships.find(params[:id]).followed
            #ログイン中のユーザーからフォローをやめる
            current_user.unfollow(@user)
        end
    end
    
    
end
