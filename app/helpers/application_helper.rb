module ApplicationHelper
  def page_class
    "#{controller_name} #{action_name}"
  end
end
