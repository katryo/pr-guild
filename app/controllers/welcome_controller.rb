class WelcomeController < ApplicationController
  def index
    @items = Item.includes(:retweets).order("created_at DESC")
    @retweets = Retweet.all
  end
end
