class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :home]
  def index
  end

  def home
    @featured = Movie.featured.approved.first(4)
    @latest = Movie.latest.approved.first(4)
    @top = Movie.top.approved.first(4)
  end
end
