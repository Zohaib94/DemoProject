class FavoriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_movie

  def create
    return nil if @movie.has_favorite?(current_user)
    @favorite_movie = @movie.favorite_movies.new
    @favorite_movie.user = current_user
    @favorite_movie.save
  end

  private

    def get_movie
      @movie = Movie.find_by_id(params[:movie_id])
      if @movie.blank?
        redirect_to root_path, notice: 'Movie not found'
      end
    end

end
