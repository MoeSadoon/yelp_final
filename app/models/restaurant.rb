class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def build_review params, user
    self.reviews.create(thoughts: params["thoughts"], rating: params["rating"], user_id: user.id)
  end

  def self.build_with_user(params, user)
    self.new(name: params['name'], user_id: user.id)
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
  end
end
