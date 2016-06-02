# coding: utf-8
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@users = []
@tags = []


@users[0] = ["てぃんくる","texinkuru"]
 @tags[0] = ["季節","ロリ","はるかぜせつな","ベル","眠れる森のお姫様","透き通るように美しく細かいロリ","グラデーション","レース","ドレス","ゴスロリ","女性キャラ","白の少女","クッキー","カナリヤ","バレンタイン","細かい","和服","アリス","版画","絵師100人展"]
 
@users[1] = ["藤真拓哉","fujima"]
 @tags[1] = ["魔法少女","ロリ","Essentia","幼女","ぴょんぴょん","砲火後ティータイム","アイマス","ゲーム","くまぱん","けいおん","Fate","μ's","あずにゃん","ヴァルキリー","ラブライブ","ラノベ","comic1","ココア","白タイツ","初音ミク","フレイヤ","FGO","ぷにとー","水着","ご注文はうさぎですか？","艦これ","SAO"]

@users[2] = ["蒼樹うめ","aoki"]
 @tags[2] = ["4コマ漫画","ねこねこソフト","うめてんてー","うめ先生","サナララ","ドージンワーク","さよなら絶望先生","ほんわか","るゆふわ","魔法少女まどかマギカ","てつなぎこおに。","笑顔ふたつ","諸葛瑾","マドの向こう側","ひだまりスケッチ","かんなぎ","デフォルメ","へちょ絵","きゅうべえ","佐倉杏子","まどか"]

@users[3] = ["秋空もみぢ","akizora"]
 @tags[3] = ["艦これ","この素晴らしい世界に祝福を！","尻","尻神様","漫画","R-18","うさぎ","シャルロット","ビスマルク","テイルズ","ニーソ","レオタード","ワンピース","ソックス","白ソックス","白ニーソックス","東方","響","連装砲ちゃん","ボディースーツ","SAO","鍵山","例大祭","オリジナル"]
 
@users[4] = ["浅海朝美","asaiumi"]
 @tags[4] = ["オリジナル"]
 




for i in 0..@users.count-1 do
    
    @avatar = File.new(File.join(Rails.root, "app/assets/images/default_avatar/"+@users[i][1]+"_a.jpg"))
    @picture = File.new(File.join(Rails.root, "app/assets/images/default_picture/"+@users[i][1]+"_p.jpg"))
    @user = User.create(name: @users[i][0],email: @users[i][1]+'@gmail.com',avatar: @avatar,picture: @picture ,age: 1 ,password: "ko",creator: true)
    
    for i2 in 0..@tags[i].count-1
        #binding.pry
        if Tag.find_by(name: @tags[i][i2])!=nil
            @tag = Tag.find_by(name: @tags[i][i2])
        else
            @tag = Tag.create(:name => @tags[i][i2])
        end
        Draw.create(user_id: @user.id,tag_id: @tag.id)
    end
end