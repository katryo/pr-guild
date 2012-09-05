#coding: utf-8
require 'spec_helper'

describe "BrowseWelcomePages" do
  it "should see the items on welcome page" do
    item = FactoryGirl.create(:item, body:"デンキノベルを見てね！", retweet_count:22)
    visit "/"
    page.should have_content("デンキノベルを見てね！")
  end
end
describe "BrowseItemsPages" do
  it "should see the all items page" do
    item = FactoryGirl.create(:item, body:"デンキノベルを見てね！", retweet_count:22)
    user = item.user
    visit items_path
    click_link "宣伝一覧"
    page.should have_content("デンキノベルを見てね！")
    page.should have_content("denki")
  end
  it "should create an pr text" do
    item = FactoryGirl.create(:item, body:"デンキノベルを見てね！", retweet_count:22)
    user = item.user
    visit items_path
    click_link "宣伝一覧"
    click_link "宣伝を登録する"
    fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！"
    #save_and_open_page
    click_button "register"
  end
end
describe "BrowseUserPages" do
  it "should see the all users page" do
    user = FactoryGirl.create(:user, name_twitter:"susie")
    visit "/"
    click_link "ユーザー一覧"
    page.should have_content("susie")
    #response.status.should be(200)
  end
end
