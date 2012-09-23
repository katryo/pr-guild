class User < ActiveRecord::Base
  after_initialize :set_default_params
  attr_accessible :name_twitter, :point, :provider_twitter, :uid_twitter, :icon_url_twitter, :description, :oauth_token_twitter, :oauth_secret_twitter
  has_many :items, :dependent => :destroy
  has_many :retweets, :dependent => :destroy

  def set_default_params
    self.point = self.point || 1
  end

  def self.from_omniauth(auth)
    where(provider_twitter: auth["provider"], uid_twitter: auth["uid"]).first || create_from_twitter_omniauth(auth)
  end

  def add_twitter_string(base)
    base << "_twitter"
  end
  def self.create_from_twitter_omniauth(auth)
    create! do |user|
      user.provider_twitter = auth["provider"]
      user.uid_twitter = auth["uid"]
      user.name_twitter = auth["info"]["nickname"]
      user.icon_url_twitter = auth["info"]["image"]
      user.description = auth["info"]["description"]
      user.oauth_token_twitter = auth["credentials"]["token"]
      user.oauth_secret_twitter = auth["credentials"]["secret"]
    end
  end
end
