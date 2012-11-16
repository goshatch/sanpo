class ApplicationController < ActionController::Base
  class AccessDenied < StandardError; end
  rescue_from AccessDenied, :with => :access_denied
  protect_from_forgery
  
  def access_denied
    redirect_to "/401.html"
  end
  
  def authenticated?
    authenticate_user! unless user_signed_in? #this is Devise's method
  end

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

  def get_user_location
    if session[:user_location_id] && UserLocation.where(:id => session[:user_location_id]).exists?
      loc = UserLocation.find(session[:user_location_id])
    else
      loc = UserLocation.new
    end
    if current_user
      loc.ip_address = current_user.current_sign_in_ip
      loc.user = current_user
    else
      loc.ip_address = request.remote_ip
    end
    # loc.ip_address = "122.103.221.209"
    # loc.ip_address = "126.169.224.101" #FIXME wtf is this??
    loc.save
    session[:user_location_id] = loc.id
    loc.geocode
    return loc
  end
end
