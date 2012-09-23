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
    Twitter.configure do |config|
      config.oauth_token = auth['credentials']['token']
      config.oauth_token_secret = auth['credentials']['secret']
    end
  end
end
