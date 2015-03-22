class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :csrf_input
  helper_method :current_user
  helper_method :login!
  helper_method :logout!
  helper_method :logged_in?

  def csrf_input
    html = <<-HTML
    <input type="hidden"
         name="authenticity_token"
         value="<%= form_authenticity_token %>">
    HTML
    html.html_safe
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end


  private
  def user_params
    params.require(:user).permit(:username, :name, :password, :password2, :email)
  end

  def require_current_user!
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
