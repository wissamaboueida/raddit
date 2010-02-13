require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many :stories,  :dependent => :nullify
  has_many :comments, :dependent => :destroy
  
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
  
  def owns?(ownable)
    ownable.user == self
  end
  
  def voted?(voteable)
    voteable.voted_by?(self)
  end
  
  def voted_for?(voteable)
    votes = voteable.class.find_votes_by_user(self)
    vote = votes.find {|v| v.voteable_id == voteable.id }
    vote && vote.voting
  end
  
  def voted_against?(voteable)
    votes = voteable.class.find_votes_by_user(self)
    vote = votes.find {|v| v.voteable_id == voteable.id }
    vote && !vote.voting
  end
  
end
