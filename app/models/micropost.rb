#このモデルの規約
class Micropost < ActiveRecord::Base
  #このオブジェクトはユーザーに紐づく
  belongs_to :user
  #user_idが必ずあること
  validates :user_id, presence: true
  #contentがあり内容は140文字以内
  validates :content, presence: true, length: { maximum: 140 }
end
