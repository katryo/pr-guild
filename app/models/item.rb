class Item < ActiveRecord::Base
  after_initialize :set_default_params
  belongs_to :user
  has_many :retweets, :dependent => :destroy
  attr_accessible :retweeted_count, :body
  validates_presence_of :user_id, :body, :retweeted_count
  validates_length_of :body, :maximum => 100


  private

  def set_default_params
   # self.retweet_count = self.retweet_count || 0
   # self.retweeted_count = self.retweeted_count || 0
  end
end


