class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :retweet_count, :body
  validates_presence_of :user_id, :body, :retweet_count
  validates_length_of :body, :maximum => 100
end
