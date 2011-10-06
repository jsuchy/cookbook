class User < ActiveRecord::Base
  has_many :recipes, :order => "title"

  validates_presence_of     :login, :email, :password, :password_confirmation, :salt
  validates_uniqueness_of   :login, :email
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of       :password, :minimum => 6
  validates_confirmation_of :password

  attr_accessor :password, :password_confirmation

  def password=(password)
    @password = password
    self.salt = (0..25).inject('') { |r, i| r << rand(93) + 33 }
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def self.authenticate(login, password)
    user = find(:first, :conditions => ["login = ?", login])
    return nil if user.nil?
    return user if User.encrypt(password, user.salt) == user.hashed_password
    return nil
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("#{password}#{salt}")
  end
end
