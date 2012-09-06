class RetweetsController < ApplicationController
  def create
    @retweet = current_user.retweets.new(params[:item])
    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @retweet, notice: 'Item was successfully created.' }
        format.json { render json: @retweet, status: :created, location: @retweet }
      else
        format.html { render action: "new" }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end
