class Relationship < ActiveRecord::Base
  #他のオブジェクトを参照するやつ
  #Userクラスに所持させたいのでクラスネームを指定する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
end
