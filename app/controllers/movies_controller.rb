class MoviesController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :add_to_favorites]
  before_action :verify_movie_approval, only: [:show]
  before_action :get_latest_reviews, only: [:show]

  def index
    params[:type] = 'all' if all_params_nil?
    @movies = Movie.index_movies(params)
    @title = [display_movie_heading(params[:type]), 'Movies'].join(' ') if params[:type].present?
  end

  def new
    @movie = Movie.new
    @actors = Actor.all
    @title = 'New Movie'
  end

  def show
    @title = @movie.title
    if user_signed_in?
      @rating = Rating.set_rating(params[:id], current_user.id)
    end
    @average_rating = Rating.average(params[:id])
    @actors = @movie.actors
  end

  def edit
    @title = 'Edit Movie'
    @actors = Actor.all
    @selected = @movie.actors.pluck(:id)
    @actors_list = @actors.collect{|actor| [actor.full_name, actor.id]}
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


  def add_to_favorites
    return nil if @movie.has_favorite?(current_user)
    @favorite_movie = @movie.favorite_movies.new
    @favorite_movie.user = current_user
    @favorite_movie.save
  end

  def sort_all
    @sorted_movies = Movie.order_movies(params).page(params[:page])
  end

  private

    def set_movie
      @movie = Movie.includes(:reviews, :attachments, :ratings, :appearances, :favorite_movies).find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :release_date, :genre, :duration, :description, :trailer_url, :featured, :approved, attachments_attributes: [:id, :image, :_destroy], actor_ids: [])
    end

    def get_latest_reviews
      @reviews = @movie.reviews.latest.includes(:user, :reported_reviews)
    end

    def verify_movie_approval
      redirect_to root_path, alert: 'Movie can not be viewed before admin approval' unless @movie.approved?
    end

    def all_params_nil?
      params[:type].nil? && params[:search].blank? && params[:actor_name].nil? && params[:title].nil? && params[:start_date].nil? && params[:end_date].nil? && params[:genre].nil?
    end

end
