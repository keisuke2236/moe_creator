class CreateSnsrerations < ActiveRecord::Migration
  def change
    create_table :snsrerations do |t|
      t.references :sns, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
