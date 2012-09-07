#coding: utf-8
class RetweetsController < ApplicationController
  def create
    @retweet = current_user.retweets.new(params[:id])
    @retweet.item_id = params[:item_id]
    respond_to do |format|
      if @retweet.save
        format.html { redirect_to "/", notice: "宣伝に成功しました！" }
        format.json { render json: "/", status: :created, location: @retweet }
      else
        format.html { render action: "new" }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end
