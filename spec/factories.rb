#coding:utf-8
FactoryGirl.define do
  factory :item do
    body "アナテマ・フィジクスを見てね！" 
    retweeted_count 10
    user
  end
  factory :user do
    sequence(:name_twitter) { |n| "denki#{n}" }
  #  description "かとりょーです"
    sequence(:uid_twitter) { |n| n + 1000 }
    retweets_count 5
  end

  factory :retweet do
    item
    user
  end
end
