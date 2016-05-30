#Userモデルとはいかなるものかを記述したファイル
#Userから取得したい変数はここに全部記述するべし
class User < ActiveRecord::Base
    #メールアドレスのアルファベットを小文字にしたやつを所持する
    #コールバック関数before_save　　セーブが行われる前に呼び出される関数
    before_save{ self.email = self.email.downcase }
    #50文字以内なおかつ〇文字以上
    validates :name, presence: true, length: { maximum: 50 }
    validates :area, presence: false, length: { maximum: 30 }, on: :update
    validates :hp, presence: false, length: { maximum: 80 }, on: :update
    validates :age , length: { maximum: 3} , presence: false, on: :update
    validates :age , numericality: {greater_than_or_equal_to:0} , presence: false, on: :update
    
    mount_uploader :avatar, AvatarUploader
    mount_uploader :picture, PictureUploader
    mount_uploader :bg, BgUploader
    
    #正規化メールアドレスの正規表現パターン，これを所持する
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
    #安全なパスワードを所持する
    has_secure_password
    #micropostsを複数持っている
    has_many :microposts
    
    #フォローしている人の塊を所持する
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    has_many :snsrerations , foreign_key: "user_id", dependent: :destroy
    has_many :snss, through: :snsrerations, source: :sns
    
    
    #user.draws = 中間テーブルが取れる　<=　Drawモデルからuser_idで取得する class_nameは省略可能
    #foreign_keyはスキーマの方のやつを使うならオーナーシップモデルに描いてあるやつじゃない
    has_many :draws, class_name: "Draw" , foreign_key: "user_id", dependent: :destroy
    #user.draw_tags ＝　タグ一覧が取れる
    #定義済みの中間テーブル（draws）のtagを取得する
    has_many :draw_tags, through: :draws, source: :tag
    
    def draw_tags_add(tag)
        #binding.pry
        draws.find_or_create_by(tag: tag)
    end
    def draw_tags_del(tag)
        self.draws.find_by(tag_id: tag.id).destroy if draw? tag
    end
    def draw?(tag)
        self.draws.find_by(tag_id: tag.id) != nil
    end
    
    has_many :likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy
    has_many :like_tags , through: :likes, source: :tag
    def like_tags_add(tag)
        #binding.pry
        likes.find_or_create_by(tag: tag)
    end
    def like_tags_del(tag)
        self.like.find_by(tag_id: tag.id).destroy
    end
    def like?(tag)
        self.like.find_by(tag_id: tag.id) != nil
    end
    
    #フォロー機能
    def follow(other_user)
        #フォローリレーションからfollowed_idで検索　値はフォローするユーザのid
        #もしそのユーザーが存在しなかったらフォローする
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    #フォロー削除機能
    def unfollow(other_user)
        #フォロー状態をフォロー一覧から持ってくる　（対象のidを探して）
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        #そのidをデストロイする  フォローが取れたならね！rails generate controller Relationships
        following_relationship.destroy if following_relationship
    end
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    
    #情報提供
    def feed_items(page)
        #ツイート一覧からユーザーidがフォローしているidに加えて自分のidも取り出す
        #配列で検索ってできるんや．．．．　　　where句つええ
        Micropost.page(page).where(user_id: following_user_ids + [self.id]).per(10)
    end
    
    
    #公式ニュース取得
    def get_news(page)
        Info.page(page).where(user_id: following_user_ids + [self.id]).per(10)
    end
end