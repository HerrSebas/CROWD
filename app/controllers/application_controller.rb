class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :identification_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :identification_number])
    # For additional in app/views/devise/registrations/edit.html.erb
  end
end
