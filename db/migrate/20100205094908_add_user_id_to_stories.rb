class AddUserIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :stories, :user_id
  end
end
