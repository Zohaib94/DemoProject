class ReportedReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reported_review, only: [:destroy]
  before_action :get_review

  def create
    return nil if @review.has_reported?(current_user)
    @reported_review = @review.reported_reviews.new
    @reported_review.user = current_user
    @reported_review.save
  end

  def destroy
    @reported_review.destroy if @reported_review
  end

  private
    def set_reported_review
      @reported_review = ReportedReview.find(params[:id])
    end

    def get_review
      @review = Review.find(params[:review_id])
    end
end
