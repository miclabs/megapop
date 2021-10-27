class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = 'You have to confirm your email address before continuing'
		new_session_path(User)
  end
end