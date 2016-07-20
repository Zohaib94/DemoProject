class Api::V1::MoviesController < Api::V1::BaseController

  respond_to :json

  def index
    movies = unless params[:title] || params[:actor_name] || params[:genre]
      Movie.all
    else
      Movie.movies_list(params)
    end
    respond_with movies.page(params[:page])
  end

  def show
    @movie = Movie.find(params[:id])
    respond_with @movie.movie_hash
  end

end
