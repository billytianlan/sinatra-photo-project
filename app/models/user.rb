class User < ActiveRecord::Base
  has_many :photos
  has_many :votes
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true


end