module AccountsHelper
  def current_user_avatar
    if current_user && current_user.avatar.present?
      url_for(current_user.avatar)
    else
      asset_path('media/users/blank.png')
    end
  end
end
