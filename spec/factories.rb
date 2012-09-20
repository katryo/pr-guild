#coding:utf-8
FactoryGirl.define do
  factory :item do
    body "アナテマ・フィジクスを見てね！" 
    user
  end
  factory :user do
    sequence(:name_twitter) { |n| "denki#{n}" }
    sequence(:uid_twitter) { |n| n + 1000 }
    point 5
  end

  factory :retweet do
    item
    user
  end
end
