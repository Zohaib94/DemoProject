class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie
  before_action :set_review, only: [:show, :edit, :update, :destroy, :report]
  before_action :review_owner, only: [:edit, :destroy]

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id
    @review.save
  end

  def update
    @review.update(review_params)
  end

  def destroy
    @review.destroy
  end

  def report
    return nil if @review.has_reported?(current_user)
    @reported_review = @review.reported_reviews.new
    @reported_review.user = current_user
    @reported_review.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment)
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_owner
      redirect_to root_path unless current_user == @review.user
    end
end
