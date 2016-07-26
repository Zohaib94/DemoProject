class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rating, only: [:update, :destroy]

  def update
    @rating.update(rating_params)
    @average = Rating.average_by_score(@rating.movie_id)
  end

  def destroy
    @rating.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:score)
    end
end
