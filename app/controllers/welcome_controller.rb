class WelcomeController < ApplicationController
  def index
    @items = Item.order("created_at DESC").limit(10)

  end
end
