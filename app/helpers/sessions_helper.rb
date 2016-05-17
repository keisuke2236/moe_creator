#様々ん外部クラスから利用できるヘルパーを作成する
#ヘルパーってようはmoduleのことだよね
#これが何かと言うとこれは全部のウェブサイト上で共通して持てるログイン情報みたいなもので
#ユーザーのIDとかも全部ここから取得できるんですよねー　（強い
#このクラスのやつを使いたいときは普通に定義したものを呼び出せばいい
#ようはここで関数定義するとincludeしていれば logged_in?　って呼び出せるようになるし
#＠current_userと定義していれば current_userとかける
module SessionsHelper
    def current_user
        #current_userがfalse または nilの時だけ代入を行う
        #なぜなら全ページで共通してこのヘルパーが呼び出されるため，
        #毎回毎回値が入っているのでfind_byをやると重いから
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    #Rails命名規則，TF形式の戻り値のメソッドには？を付けるらしい
    def logged_in?
        #urrent_userがnilの場合、!current_userがtrueになり、もう一度!をつけるとtrueが反転してfalseになる
        !!current_user
    end
    
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end