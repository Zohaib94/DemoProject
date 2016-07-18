class FavoriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_movie

  def create
    unless @movie.has_favorite?(current_user)
      @favorite_movie = @movie.favorite_movies.build
      @favorite_movie.user = current_user
      if @favorite_movie.save
        @message = 'Successfully added to favorites'
      else
        @message = 'Failed to add to favorites'
      end
    else
      @message = 'Already a Favorite'
    end
  end

  private

    def get_movie
      @movie = Movie.find_by_id(params[:movie_id])
      if @movie.blank?
        redirect_to root_path, notice: 'Movie not found'
      end
    end

end
