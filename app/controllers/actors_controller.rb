class ActorsController < ApplicationController
  before_action :set_actor, only: [:show]

  def show
    @title = @actor.full_name
    @movies = @actor.movies.includes(:attachments).page(params[:page])
  end

  private
    def set_actor
      @actor = Actor.includes(:attachments, :appearances).find(params[:id])
    end
end
