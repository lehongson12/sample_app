class AddTitleToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :title, :text
  end
end
