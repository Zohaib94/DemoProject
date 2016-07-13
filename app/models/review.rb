class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  has_many :reported_reviews

  def has_reported?(user)
    self.reported_reviews.where(user: user).count > 0
  end
end
