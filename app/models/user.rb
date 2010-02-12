require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many :stories,  :dependent => :nullify
  has_many :comments, :dependent => :destroy
  has_many :radds,    :dependent => :destroy do
    def for
      find_all_by_vote(true)
    end
    
    def against
      find_all_by_vote(false)
    end
    
    def net_count
      self.for.count - self.against.count
    end
  end
  
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message
  
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100
  
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  validates_inclusion_of    :country,  :in => COUNTRY_CODES.map(&:last), :allow_blank => true
  
  attr_accessible :login, :email, :name, :password, :password_confirmation,
                  :location, :country, :postal_code, :birthdate, :about_me
  
  # Authenticates a user by their login name and unencrypted password.
  # Returns the user or nil.
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end
  
  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def has_radd?(story)
    !!radds.find_by_story_id_and_vote(story.id, true)
  end
  
  def has_buried?(story)
    !!radds.find_by_story_id_and_vote(story.id, false)
  end
  
  def has_radd_or_buried?(story)
    has_radd?(story) || has_buried?(story)
  end
  
  def owns?(ownable)
    ownable.user == self
  end
  
end
