class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @favorite_movies = @user.get_favorite_movies.includes(:attachments).page(params[:page])
  end

  private
  def set_user
    @user = User.includes(:favorite_movies).find(params[:id])
  end

end
