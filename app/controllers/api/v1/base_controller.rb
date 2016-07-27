class Api::V1::BaseController < ApplicationController
  before_action :authenticate_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  TOKEN = 'C167417CA74E3222'

  def not_found
    render json: { error: "record not found", status: 404 }
  end

  private
    def authenticate_request
      head :unauthorized unless request.headers['Authorization'] == TOKEN
    end
end
