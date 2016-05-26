class AddInfoToToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :info_to, :integer
  end
end
