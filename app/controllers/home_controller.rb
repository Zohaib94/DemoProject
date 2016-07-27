class HomeController < ApplicationController
  def index
    @featured_movies = Movie.includes(:attachments).featured.approved.first(4)
    @latest_movies = Movie.includes(:attachments).latest.approved.first(4)
    @top_movies = Movie.includes(:attachments, :ratings).top.approved.first(4)
  end
end
