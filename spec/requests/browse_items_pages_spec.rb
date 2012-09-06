#coding: utf-8
require 'spec_helper'

describe "A user who is not logged in" do
  it "should see the items on welcome page" do
    user = FactoryGirl.create(:user)
    item = FactoryGirl.create(:item)
    user = item.user
    visit "/"
    page.should have_content("アナテマ・フィジクスを見てね！")
  end
  it "should see the all items page" do
    item = FactoryGirl.create(:item, body:"デンキノベルを見てね！", retweeted_count:22)
    user = item.user
    visit items_path
    click_link "宣伝一覧"
    page.should have_content("デンキノベルを見てね！")
    page.should have_content("denki")
  end
  it "should see the all users page" do
    user = FactoryGirl.create(:user, name_twitter:"susie")
    visit "/"
    click_link "ユーザー一覧"
    page.should have_content "ユーザー一覧"
    page.should have_content("susie")
  end
end

describe "A logged in user" do
  before do
    OmniAuth.config.test_mode = true
    user = FactoryGirl.create(:user)
    OmniAuth.config.mock_auth[:twitter] = {
      :uid => 11111,
      :provider => "twitter",
      :info => {
      :description => "こんにちはこんにちは！"
    }
    }
  end

  after do
    OmniAuth.config.test_mode = false
  end
  describe "in items page" do
    it "should be written by a login user" do
      visit "/auth/twitter"
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスをぜひプレイしてみて！")
      page.should have_content("Edit")
      click_link "ユーザー一覧"
      page.should have_content("denki")
    end

    it "should not see edit link" do
      visit "/auth/twitter"
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスをぜひプレイしてみて！")
      click_link "ログアウトする"
      click_link "宣伝一覧"
      page.should have_no_content("Edit")
    end

    it "should not be registerd when filled text is longer than 100" do
      visit "/auth/twitter"
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      page.should have_content("error")
  end

    it "should retweet when user push the button" do
    item = FactoryGirl.create(:item)
      visit "/auth/twitter"
      visit items_path
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスを見てね！")
      page.should have_content("10")
      click_link "宣伝する"
      page.should have_content("宣伝しました！")
    end
  end
end
