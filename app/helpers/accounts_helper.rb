module AccountsHelper
  def current_user_avatar
    user_avatar(current_user)
  end

  def user_avatar user
  	if user && user.avatar.present?
      url_for(user.avatar)
    else
      asset_path('media/users/blank.png')
    end
  end
end
