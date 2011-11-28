class SessionsController < ApplicationController
  before_filter :parse_facebook_cookies


  def new
    
  end

  def create
    auth = @facebook_cookies
    user = User.where(:uid => auth['user_id']).first || User.create_fb_user(auth,get_graph)
    session[:uid] = user.uid
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end
  

  
end
