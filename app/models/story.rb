class Story < ActiveRecord::Base
  MEDIA_TYPES = %w( news video image )
  
  belongs_to :user
  has_many :comments, :conditions => ["reply_to_id = ?", 0],
                      :dependent => :destroy
  has_many :radds,    :dependent => :destroy
  
  validates_presence_of   :title
  
  validates_presence_of   :link
  validates_uniqueness_of :link
  validates_length_of     :link, :maximum => 255
  validates_format_of     :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  validates_presence_of   :media
  validates_inclusion_of  :media, :in => MEDIA_TYPES
  
  validates_presence_of   :user_id
  
end
