class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      #勝手に番号をつけて欲しい
      t.references :user, index: true
      t.references :tag, index: true
      
      t.timestamps null: false
    end
  end
end
