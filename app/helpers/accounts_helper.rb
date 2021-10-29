module AccountsHelper
  def current_user_avatar
    if current_user && current_user.avatar.present?
      user.avatar.variant(:thumb)
    else
      asset_path('media/users/blank.png')
    end
  end
end
