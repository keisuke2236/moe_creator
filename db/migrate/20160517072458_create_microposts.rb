class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      #useridに対してインデックスを作成して超高速化する
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      #複合index 複数のインデックスを作成することで　user.idとそのユーザーが作ったものをくっつけた状態での並び替えが超高速化する
      t.index [:user_id, :created_at]
    end
  end
end
