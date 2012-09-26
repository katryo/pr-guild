#coding: utf-8
class RetweetsController < ApplicationController
  def create
    @retweet = current_user.retweets.new(params[:id])
    @retweet.item_id = params[:item_id]

    if tweet_with_oauth
    current_user.point += 1
    current_user.save
      @retweet.item.user.point -= 1
      @retweet.item.user.save
      respond_to do |format|
        if @retweet.save
          format.html { redirect_to items_path, notice: "宣伝に成功しました！" }
          format.json { render json: "/", status: :created, location: @retweet }
        else
          format.html { render action: "new" }
          format.json { render json: @retweet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
  end

  def tweet_with_oauth
    begin
      @client.update("text")
    rescue
      redirect_to :back, alert: "宣伝に失敗しました! API制限かも？"
      false
    end
  end

end
