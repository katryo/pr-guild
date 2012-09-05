#coding:utf-8
FactoryGirl.define do
  factory :item do
    body "アナテマ・フィジクス見てね！" 
    retweet_count 10
    user
  end
  factory :user do
    sequence(:name_twitter) { |n| "denki#{n}" }
  end
end
