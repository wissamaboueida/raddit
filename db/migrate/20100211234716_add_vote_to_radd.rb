class AddVoteToRadd < ActiveRecord::Migration
  def self.up
    add_column :radds, :vote, :boolean, :default => true
  end

  def self.down
    remove_column :radds, :vote
  end
end
