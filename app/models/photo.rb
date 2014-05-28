class Photo ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :url, presence: true
end