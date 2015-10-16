class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements, dependent: :delete_all
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: 'has reviewed this restaurant already' }
end
