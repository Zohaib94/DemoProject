class Api::V1::MoviesController < Api::V1::BaseController
  before_action :get_movie, only: [:show]
  respond_to :json

  def index
    movies = unless params[:title] || params[:actor_name] || params[:genre]
      Movie.all
    else
      Movie.search_movies(params)
    end
    respond_with movies.page(params[:page])
  end

  def show
    respond_with @movie.movie_hash(request.env['HTTP_HOST'].to_s)
  end

  private

  def get_movie
    @movie = Movie.find(params[:id])
  end

end
