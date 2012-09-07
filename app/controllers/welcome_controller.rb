class WelcomeController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
    @retweets = Retweet.all
  end
end
