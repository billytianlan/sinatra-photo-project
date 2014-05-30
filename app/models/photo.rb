class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
  has_many :votes
  validates :url, presence: true
end