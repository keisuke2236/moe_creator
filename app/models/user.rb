#Userモデルとはいかなるものかを記述したファイル
class User < ActiveRecord::Base
    #メールアドレスのアルファベットを小文字にしたやつを所持する
    #コールバック関数before_save　　セーブが行われる前に呼び出される関数
    before_save{ self.email = self.email.downcase }
    #50文字以内なおかつ〇文字以上
    validates :name, presence: true, length: { maximum: 50 }
    validates :area, presence: false, length: { maximum: 30 }, on: :update
    validates :hp, presence: false, length: { maximum: 80 }, on: :update
    validates :age , length: { maximum: 3} , presence: true, on: :update
    validates :age , numericality: {greater_than_or_equal_to:0} , presence: false, on: :update
    
    
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
end
