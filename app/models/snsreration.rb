class Snsreration < ActiveRecord::Base
  belongs_to :user, class_name: "User"  # ユーザー
  belongs_to :sns, class_name: "Sns"  # やっているSNS情報
end
