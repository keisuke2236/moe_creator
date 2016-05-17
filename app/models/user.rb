class User < ActiveRecord::Base
    #メールアドレスのアルファベットを小文字にする
    #コールバック関数before_save　　セーブが行われる前に呼び出される関数
    before_save{ self.email = self.email.downcase }
    #50文字以内なおかつ〇文字以上
    validates :name, presence: true, length: { maximum: 50 }
    
    #正規化メールアドレスの正規表現パターン
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
    
    has_secure_password
end
