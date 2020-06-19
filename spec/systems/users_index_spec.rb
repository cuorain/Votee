require 'rails_helper'

RSpec.describe "users/index", type: :system do
  before(:each) do
    100.times {create(:mob_user)}
  end
  describe "ユーザー検索ページ" do
    it "ユーザーが表示されているか" do
      visit users_path
      expect(page).to have_content User.first.name
    end

    it "検索したユーザーが表示されているか" do
      visit users_path
      fill_in 'search', with: "test1"
      click_on '検索', class: "btn"
      expect(page).to have_content "test1"
      expect(page).not_to have_content "test2"
    end

    it "検索したユーザーがいない時、メッセージ表示" do
      visit users_path
      fill_in 'search', with: "test1"
      click_on '検索', class: "btn"
      expect(page).to have_content "該当するユーザが見つかりません"
    end

    it "ページネーションが表示されているか" do
      visit users_path
      expect(page).to have_css ".pagination"
    end
  end
end
