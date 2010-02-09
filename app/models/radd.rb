class Radd < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  
  validates_presence_of   :user_id
  
  validates_presence_of   :story_id
  validates_uniqueness_of :story_id, :scope => :user_id
  
end
