require 'digest'

class User < ActiveRecord::Base
  belongs_to :role

  before_save :encrypt_new_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    sub_salt = encrypt(self.salt[8,5])
    self.password == (encrypt(password).insert(9,sub_salt))
  end

  protected
    def encrypt_new_password
      return if password.blank?
      salt = encrypt(Time.now.to_s+self.email)
      self.salt = salt
      sub_salt = encrypt(self.salt[8,5])
      self.password = encrypt(password).insert(9,sub_salt)
    end

    def password_required?
      self.password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end
