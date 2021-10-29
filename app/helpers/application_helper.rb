module ApplicationHelper
  def user_roles
    {
      creator: 'Creator', 
      credit_manager: 'Credit Manager', 
      admin: 'Administrator'
    }
  end
end
