class Comment < ActiveRecord::Base
  acts_as_voteable
  
  belongs_to :user
  belongs_to :story
  belongs_to :reply_to, :class_name => "Comment"
  has_many   :replies,  :class_name => "Comment",
                        :foreign_key => "reply_to_id",
                        :dependent => :destroy do
    def highest_sum_of_votes
      all.map(&:sum_of_votes).max
    end
  end
  
  validates_presence_of   :content
  
  validates_presence_of   :user_id
  validates_presence_of   :story_id
  
  def is_editable?
    created_at > 5.minutes.ago
  end
  
  def sum_of_votes
    number_of_votes_for - number_of_votes_against
  end
  
end
