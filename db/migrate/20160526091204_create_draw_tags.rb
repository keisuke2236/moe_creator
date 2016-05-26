class CreateDrawTags < ActiveRecord::Migration
  def change
    create_table :draw_tags do |t|
      t.integer :tag_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
