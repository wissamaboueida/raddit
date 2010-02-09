class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text    :content
      t.integer :user_id,     :null => false
      t.integer :story_id,    :null => false
      t.integer :reply_to_id, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
