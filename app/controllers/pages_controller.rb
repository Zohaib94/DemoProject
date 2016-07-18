class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :home]
  def index
  end

  def home
    @featured_movies = Movie.featured.approved.first(4)
    @latest_movies = Movie.latest.approved.first(4)
    @top_movies = Movie.top.approved.first(4)
  end
end
