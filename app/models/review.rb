class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie
  has_many :reported_reviews, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 50 }

  def has_reported?(user)
    self.reported_reviews.where(user: user).count > 0
  end

  def reporters
    reporter_ids = self.reported_reviews.pluck(:user_id)
    User.where(id: reporter_ids).collect(&:full_name).join(',')
  end

end
