class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :user_id
      t.string :text
      t.string :link

      t.timestamps null: false
    end
  end
end
