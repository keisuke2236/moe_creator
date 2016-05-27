class SnssController < ApplicationController
    def edit
        if current_user==nil || params["id"]!=current_user.id.to_s
            redirect_to root_path 
        else
            @user = current_user
            @sns = Sns.new
            @snss = Sns.where(user_id:current_user.id)
        end
    end
    
    def update
        #binding.pry
    end
    
    def create
        #Paramsの中から値を取得．sns_paramsでSns型に当てはまらない不要なデータ型を削除する
        @sns = Sns.new(sns_params)
        @sns.user_id = current_user.id
        if @sns.save
            flash[:success] = "#{@sns.name}のURLを登録しました！"
            redirect_to :action => "edit", :id => current_user.id
        else
            flash[:success] = "#{@sns.name}のURLを登録できませんでした"
            redirect_to :action => "edit", :id => current_user.id
        end
        
    end
    
    def destroy
        if current_user==nil || params["id"]!=current_user.id.to_s
            redirect_to root_path 
        else
            Sns.find_by(id: params["del_id"]).destroy
            redirect_to :action => "edit", :id => current_user.id
        end
    end
    
     #createで新しい要素を作成するときに無駄な変数をカットする
    def sns_params
        params.require(:sns).permit(:name, :url, :user_id)
    end
end
