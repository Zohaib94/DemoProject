module ReviewsHelper
  def is_review_owner?(review, user)
    review.user_id == user.id
  end
end
