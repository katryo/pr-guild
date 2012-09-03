class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :retweet_count
end
