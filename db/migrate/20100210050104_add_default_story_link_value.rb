class AddDefaultStoryLinkValue < ActiveRecord::Migration
  def self.up
    change_column :stories, :link, :string, :default => "http://" , :null => false
  end

  def self.down
    change_column :stories, :link, :string
  end
end
