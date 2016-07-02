class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :home]
  def index
  end

  def home
    @featured = Movie.featured.first(3)
    @latest = Movie.latest.first(3)
  end
end
