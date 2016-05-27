class Ownership < ActiveRecord::Base
  belongs_to :user, class_name: "User"  # ユーザー
  belongs_to :tag, class_name: "Tag"  # タグ
end
