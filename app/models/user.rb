class User < ActiveRecord::Base
  attr_accessible :name_twitter, :point, :provider_twitter, :retweets_count, :uid_twitter, :icon_url_twitter

  def self.from_omniauth(auth)
    where(auth.slice("provider_twitter", "uid_twitter")).first || create_from_twitter_omniauth(auth)
  end

  def self.create_from_twitter_omniauth(auth)
    create! do |user|
      user.provider_twitter = auth["provider"]
      user.uid_twitter = auth["uid"]
      user.name_twitter = auth["info"]["nickname"]
      user.icon_url_twitter = auth["info"]["image"]
    end
  end
end
