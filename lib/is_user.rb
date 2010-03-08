module IsUser
  require 'digest/sha2'
  require 'active_support/secure_random'

  def is_user
    attr_accessible :username, :email_address, :password, :password_confirmation

    attr_accessor :password, :password_confirmation

    validates :username, :format => { :with => /^[-\w\._@]+$/i }, :presence => true, :uniqueness => true
    validates :email_address, :presence => true, :format => { :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i }, :uniqueness => true
    validates :password, :presence => true, :confirmation => true, :length => { :minimum => 4 }
    validates :password_confirmation, :presence => true, :if => :password_changed?

    before_save :hash_password!, :if => :password_changed?
    before_create :generate_verification_key!

    def authenticate(email_address, password)
      user = User.find_by_email_address(email_address)

      if user && user.verified? && user.password_hash == Digest::SHA2.hexdigest(password + user.password_salt)
        return user
      end

      nil
    end

    include InstanceMethods
  end

  module InstanceMethods
    def verified?
      !self.verified_at.nil?
    end

    def verify(key)
      if !self.verified? && key == self.verification_key
        self.update_attribute(:verified_at, Time.now)
        return true
      end

      false
    end

  protected
    def password_changed?
      !@password.blank?
    end

    def hash_password!
      self.password_salt = Digest::SHA2.hexdigest(ActiveSupport::SecureRandom.base64(8))
      self.password_hash = Digest::SHA2.hexdigest(@password + self.password_salt)
    end

    def generate_verification_key!(length = 16)
      self.verification_key = ActiveSupport::SecureRandom.hex(length)
    end
  end
end

ActiveRecord::Base.extend IsUser
