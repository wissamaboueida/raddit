class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :reply_to, :class_name => "Comment"
  has_many   :replies,  :class_name => "Comment",
                        :foreign_key => "reply_to_id",
                        :dependent => :destroy
  
  validates_presence_of   :content
  
  validates_presence_of   :user_id
  validates_presence_of   :story_id
  
  
end
