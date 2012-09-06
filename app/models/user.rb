class User < ActiveRecord::Base
  after_initialize :set_default_params
  attr_accessible :name_twitter, :point, :provider_twitter, :retweets_count, :uid_twitter, :icon_url_twitter, :description
  has_many :items, :dependent => :destroy
  has_many :retweets, :dependent => :destroy

  def set_default_params
    self.point = self.point || 0
    self.retweets_count = self.retweets_count || 0
  end

  def self.from_omniauth(auth)
    where(auth.slice("provider_twitter", "uid_twitter")).first || create_from_twitter_omniauth(auth)
  end

  def self.create_from_twitter_omniauth(auth)
    create! do |user|
      user.provider_twitter = auth["provider"]
      user.uid_twitter = auth["uid"]
      user.name_twitter = auth["info"]["nickname"]
      user.icon_url_twitter = auth["info"]["image"]
      user.description = auth["info"]["description"]
    end
  end
end
