class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :home]
  def index
  end

  def home
    @featured = Movie.featured_four
    @latest = Movie.latest_four
    @top = Movie.top_four
  end
end
