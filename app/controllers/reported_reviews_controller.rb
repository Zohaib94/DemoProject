class ReportedReviewsController < ApplicationController
  before_action :set_reported_review, only: [:destroy]
  before_action :get_review
  before_action :authenticate_user!

  def create
    unless @review.has_reported?(current_user)
      @reported_review = @review.reported_reviews.build
      @reported_review.user = current_user
      @reported_review.save
    end
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
