class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender, :birth_date])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :gender, :birth_date, attachment_attributes: [:id, :image, :_destroy]])
    end

    def not_found
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
end
