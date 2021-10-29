class RegistrationsController < Devise::RegistrationsController
	
	def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = 'You have to confirm your email address before continuing'
		new_session_path(User)
  end
end