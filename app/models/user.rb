require 'bcrypt'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 64 }
  validates :email, presence: true, length: { minimum: 5, maximum: 500 }
  validates :password, presence: true, uniqueness: true, length: { minimum: 8, maximum: 64 }

  has_many :sessions
  has_many :tweets

  after_validation :encrypt_password

  private
    def encrypt_password
      self.password = BCrypt::Password.create(self.password)
    end
end
