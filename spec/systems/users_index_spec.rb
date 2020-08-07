require 'rails_helper'

RSpec.describe "users/index", type: :system do
  before(:each) do
    50.times {create(:mob_user)}
  end

  context "ユーザー検索ページ" do
    example "ユーザーが表示されているか" do
      visit users_path
      expect(page).to have_content User.first.name
    end

    example "検索したユーザーが表示されているか" do
      visit users_path
      fill_in 'search', with: "test1"
      click_on '検索', class: "btn"
      expect(page).to have_content "test1"
      expect(page).not_to have_content "test2"
    end

    example "検索したユーザーがいない時、メッセージ表示" do
      visit users_path
      fill_in 'search', with: "test1000"
      click_on '検索', class: "btn"
      expect(page).to have_content "該当するユーザが見つかりません"
    end

    example "ページネーションが表示されているか" do
      visit users_path
      expect(page).to have_css ".pagination"
    end

    example "管理者ログインの時、削除ボタンあるか" do
      create(:admin)
      admin_login(:admin)
      visit users_path
      expect(page).to have_content "削除"
    end
  end
end
