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
    item = FactoryGirl.create(:item, body:"デンキノベルを見てね！")
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
      "uid" => "11111",
      "provider" => "twitter",
      "info" => {
      "description" => "こんにちはこんにちは！",
      "nickname" => "katryo",
      "image" => "http://image.jpg"
    }
    }
    visit "/auth/twitter"
  end

  after do
    OmniAuth.config.test_mode = false
  end
  describe "in items page" do
    it "should be written by a login user and find info in the user page" do
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスをぜひプレイしてみて！")
      page.should have_content("編集")
      click_link "ユーザー一覧"
      page.should have_content("denki")
      visit users_path
      page.should have_content("5ポイント")
      page.should have_content("denki")
      click_link "katryoの詳細"
      page.should have_content("アナテマ")
      page.should have_content("削除する")

    end

    it "should not see edit link" do
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスをぜひプレイしてみて！")
      click_link "ログアウトする"
      click_link "宣伝一覧"
      page.should have_no_content("編集")
    end

    it "should not be registerd when filled text is longer than 100" do
      visit items_path
      click_link "宣伝一覧"
      click_link "宣伝を登録する"
      fill_in "item_body", :with => "アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！アナテマ・フィジクスをぜひプレイしてみて！"
      click_button "登録"
      page.should have_content("error")
    end

    it "should retweet when user push the button" do
      item = FactoryGirl.create(:item)
      visit items_path
      click_link "宣伝一覧"
      page.should have_content("アナテマ・フィジクスを見てね！")
      page.should have_content("0回宣伝されている")
      click_link "宣伝する"
      page.should have_content("宣伝に成功しました！")
      page.should have_content("2ポイント")
      page.should have_content("4ポイント")
    end
  end


  describe "A logged in user" do
    before do
      OmniAuth.config.test_mode = true
      item = FactoryGirl.create(:item, body: "音楽を聴いて！")
      user = FactoryGirl.create(:user)
      OmniAuth.config.mock_auth[:twitter] = {
        "uid" => "11111",
        "provider" => "twitter",
        "info" => {
        "description" => "こんにちはこんにちは！",
        "nickname" => "katryo",
        "image" => "http://image.jpg"
      }
      }
      visit "/auth/twitter"
    end

    after do
      OmniAuth.config.test_mode = false
    end
    it "should decrease point from the user who created the item" do
      visit items_path
      click_link "宣伝一覧"
      page.should have_content("0回宣伝されている")
      click_link "宣伝する"
      page.should have_content("宣伝に成功しました！")
      page.should have_content("2ポイント")
      page.should have_content("(4ポイント)")
      click_link "宣伝する"
      click_link "宣伝する"
      click_link "宣伝する"
      click_link "宣伝する"
      page.should have_no_content("音楽を聴いて！")
      visit "/"
      page.should have_no_content("音楽を聴いて！")
      page.should have_content("6ポイント")
    end

  end

  describe "An admin user" do
    before do
      OmniAuth.config.test_mode = true
      item = FactoryGirl.create(:item, body: "音楽を聴いて！")
      user = FactoryGirl.create(:user)
      OmniAuth.config.mock_auth[:twitter] = {
        "uid" => "11111",
        "provider" => "twitter",
        "info" => {
        "description" => "こんにちはこんにちは！",
        "nickname" => "katryo",
        "image" => "http://image.jpg"
      }
      }
      visit "/auth/twitter"
    end

    after do
      OmniAuth.config.test_mode = false
    end
    it "should decrease point from the user who created the item" do
      visit admin_path
      click_link "全ユーザーのポイントを半分にする"
      visit items_path
      save_and_open_page
      page.should have_content("2ポイント")
    end
  end
end
