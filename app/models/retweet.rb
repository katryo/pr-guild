class Retweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  # attr_accessible :title, :body
end
