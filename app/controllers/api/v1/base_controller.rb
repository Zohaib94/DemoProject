class Api::V1::BaseController < ApplicationController
  before_action :authenticate_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ThinkingSphinx::ConnectionError, with: :search_not_available

  TOKEN = 'C167417CA74E3222'

  def not_found
    render json: { error: "record not found", status: 404 }
  end

  private
    def authenticate_request
      head :unauthorized unless request.headers['Authorization'] == TOKEN
    end

    def search_not_available
      render json: { error: "Search is not available at the moment. Please try later", status: 404 }
    end
end
