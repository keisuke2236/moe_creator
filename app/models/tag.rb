class Tag < ActiveRecord::Base
    validates :name, presence: true, length: { maximum: 15 }
    #user.draws = 中間テーブルが取れる　<=　Drawモデルからuser_idで取得する class_nameは省略可能
    has_many :draws, class_name: "Draw" , foreign_key: "tag_id", dependent: :destroy
    #user.draw_tags ＝　タグ一覧が取れる
    #定義済みの中間テーブル（draws）のtagを取得する
    has_many :draw_users, through: :draws, source: :user
    
    has_many :likes, class_name: "Like", foreign_key: "tag_id", dependent: :destroy
    has_many :like_users , through: :likes, source: :user
end