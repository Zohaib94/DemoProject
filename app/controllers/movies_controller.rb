class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
    @actors = Actor.all
  end

  def edit
    @actors = Actor.all
    @selected = @movie.actors.pluck(:id)
    @actors_list = @actors.collect{|actor| [actor.name, actor.id]}
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        @actors = Actor.all
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        @actors = Actor.all
        @selected = @movie.actors.pluck(:id)
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :release_date, :genre, :duration, :description, :trailer_url, :featured, :approved, attachments_attributes: [:id, :image, :_destroy], actor_ids: [])
    end
end
