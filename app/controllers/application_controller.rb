class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ThinkingSphinx::ConnectionError, with: :search_not_available

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender, :birth_date])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :gender, :birth_date, attachment_attributes: [:id, :image, :_destroy]])
    end

    def not_found
      redirect_to root_path, alert: 'Not Found, Try again'
    end

    def search_not_available
      redirect_to root_path, alert: 'Search is not available at the moment. Please try later'
    end
end
