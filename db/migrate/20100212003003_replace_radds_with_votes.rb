class ReplaceRaddsWithVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string   "voteable_type", :default => ""
      t.integer  "voteable_id",   :default => 0
      t.integer  "user_id",       :default => 0
      t.boolean  "voting"

      t.timestamps
    end

    add_index :votes, [:voteable_type, :voteable_id, :user_id]
    add_index :votes, [:voteable_type, :voteable_id, :voting]

    drop_table :radds
  end

  def self.down
    create_table "radds", :force => true do |t|
      t.integer  "user_id",                      :null => false
      t.integer  "story_id",                     :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "vote",       :default => true
    end

    drop_table :votes
  end
end
