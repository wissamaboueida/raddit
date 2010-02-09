class CreateRadds < ActiveRecord::Migration
  def self.up
    create_table :radds do |t|
      t.integer :user_id,  :null => false
      t.integer :story_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :radds
  end
end
