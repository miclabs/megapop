class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(
          :ssn, :zip_code, :phone_number, :first_name, 
          :last_name, :street_address_1, :street_address_2,  :postcode, 
          :city, :state, :email, :password, :password_confirmation)
       }
    end
end
