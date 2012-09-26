#coding: utf-8
class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    set_twitter_config(request.env["omniauth.auth"])
    redirect_to root_url, notice: "ログインしました" 
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end

  def set_twitter_config(auth)
    @client = Twitter::Client.new(
      :oauth_token => "20364161-CCObAMEuhCKKaoOMa16exmr5OR0eJs8JGJLe8TYZ0",
      :oauth_token_secret => "R2bDZoqmaGNi9FnHqXrWUkdIefXN88hEBo3BWyN0g"
    )
    #    Twitter.configure do |config|
    #      config.oauth_token = auth['credentials']['token']
    #      config.oauth_token_secret = auth['credentials']['secret']
    #    end
  end
end
