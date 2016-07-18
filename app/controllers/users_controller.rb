class UsersController < ApplicationController
  before_action :set_user

  def show
    @favorite_movies = @user.get_favorite_movies.page(params[:page])
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end
