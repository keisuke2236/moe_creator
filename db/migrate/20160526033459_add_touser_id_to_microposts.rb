class AddTouserIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :touser_id, :integer
  end
end
