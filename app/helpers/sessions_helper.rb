#様々ん外部クラスから利用できるヘルパーを作成する
#ヘルパーってようはmoduleのことだよね
#これが何かと言うとこれは全部のウェブサイト上で共通して持てるログイン情報みたいなもので
#ユーザーのIDとかも全部ここから取得できるんですよねー　（強い
module SessionsHelper
    def current_user
        #現在のユーザーに Userモデルからidがsession[:id]なものを探してログイン中だったらTrueを返す
        @current_user ||= User.find_by(id: session[:user_id])
        
        #書き換えると TF形式で返されることがわかった
        #@current_user = @current_user || User.find_by(id: session[:id])
    end
    
    #Rails命名規則，TF形式の戻り値のメソッドには？を付けるらしい
    def logged_in?
        #カレントユーザーのログイン状態　!!はnilのときにfalseを返すようにするためのやつで　否定という意味は一切ない
        !!current_user
    end
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end