class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :location,    :string, :limit => 40, :default => ""
    add_column :users, :country,     :string, :limit => 2,  :default => ""
    add_column :users, :postal_code, :string,               :default => ""
    add_column :users, :birthdate,   :date
    add_column :users, :about_me,    :text
  end

  def self.down
    remove_column :users, :location
    remove_column :users, :country
    remove_column :users, :postal_code
    remove_column :users, :birthdate
    remove_column :users, :about_me
  end
end
