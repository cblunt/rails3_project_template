require 'digest/sha2'

class User < ActiveRecord::Base
  validates_presence_of :email_address, :password_hash

  def password=(pass)
    @password =  pass
    return if @password.blank? 

    self.password_salt = Digest::SHA2.hexdigest(Time.now.to_s + rand(32000).to_s)
    self.password_hash = Digest::SHA2.hexdigest(@password + self.password_salt)
  end

protected
  def password
    @password
  end
end
