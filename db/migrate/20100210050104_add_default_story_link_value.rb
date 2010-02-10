class AddDefaultStoryLinkValue < ActiveRecord::Migration
  def self.up
    change_column :stories, :link, :default => "http://" , :null => false
  end

  def self.down
  end
end
