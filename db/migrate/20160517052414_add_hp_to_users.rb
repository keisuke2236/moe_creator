class AddHpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hp, :string
  end
end
