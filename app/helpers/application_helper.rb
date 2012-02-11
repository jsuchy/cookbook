module ApplicationHelper
  def iphone_user_agent?(request)
    return true if request.user_agent =~ /(Mobile\/.+Safari)/
    return false
  end

  def logged_in?
    return true if session[:user_id]
    return false
  end
end
