class Story < ActiveRecord::Base
  MEDIA_TYPES = %w( news video image )
  
  acts_as_voteable
  
  belongs_to :user
  has_many :comments, :conditions => ["reply_to_id = ?", 0],
                      :dependent => :destroy
  
  validates_presence_of   :title
  
  validates_presence_of   :link
  validates_uniqueness_of :link
  validates_length_of     :link, :maximum => 255
  validates_format_of     :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  validates_presence_of   :media
  validates_inclusion_of  :media, :in => MEDIA_TYPES
  
  validates_presence_of   :user_id
  
  def sum_of_votes
    number_of_votes_for - number_of_votes_against
  end
  
end
