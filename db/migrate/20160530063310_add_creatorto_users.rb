class AddCreatortoUsers < ActiveRecord::Migration
  def change
    add_column :users, :creator, :boolean
  end
end
