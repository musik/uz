class AddFansCountToApp < ActiveRecord::Migration
  def change
    add_column :apps, :fans_count, :integer
    add_index :apps,:fans_count,name: "fans_count"
    add_index :apps,:uv,name: "uv"
  end
end
