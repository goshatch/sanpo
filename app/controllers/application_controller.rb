class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    path = ''
    if session[:next]
      path = session[:next]
      session[:next] = nil
    else
      path = super
    end

    path
  end
end
