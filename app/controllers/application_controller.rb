class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
  def current_user
    fb = check_for_session if session[:uid].blank?
    db = check_for_db_user
    if !fb.nil? && @current_user.nil?
      graph = get_graph
      @current_user = User.create_fb_user(@facebook_cookies,graph)
    end
    @current_user
  end

  def check_for_db_user
    begin
      @current_user = User.find_by_uid(session[:uid]) if session[:uid] && @current_user.blank?
    rescue 
      nil
    end
  end

  def check_for_session
    parse_facebook_cookies 
    unless @facebook_cookies.nil?
      session[:uid] = @facebook_cookies["user_id"]
    end
  end

  def parse_facebook_cookies
    @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies) rescue nil
    logger.info "parse method:  #{@facebook_cookies}"
  end

  def get_graph
    @access_token = @facebook_cookies["access_token"]
    @graph = Koala::Facebook::API.new(@access_token)
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to new_session_path, :alert => 'You need to sign in for access to this page.'
    end
  end
  
end
