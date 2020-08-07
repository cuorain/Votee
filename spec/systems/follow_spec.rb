require 'rails_helper'

RSpec.describe "フォロー機能", type: :system do
  before(:each) do
    @user = create(:user)
    @other = create(:other)
    @other2 = create(:new_user)
    login(:user)
  end

  context "フォロー" do
    example "フォローして、解除する" do
      visit user_path(@other)
      expect(page).to have_button "フォロー"
      click_button "フォロー"
      expect(page).to have_selector "#follower-count", text: "1"
      expect(page).to have_button "フォロー解除"
      click_on "フォロー解除"
      expect(page).to have_selector "#follower-count", text: "0"
      expect(page).to have_button "フォロー"
    end

    example "自分のページにはボタンがない" do
      visit user_path(@user)
      expect(page).not_to have_button "フォロー"
    end
  end

  context "フォロー、フォロワー" do
    example "フォロー一覧" do
      visit user_path(@other)
      click_button "フォロー"
      visit root_path
      click_on "フォロー"
      expect(page).to have_content @other.name
    end
    example "フォロワー一覧" do
      visit user_path(@other)
      click_button "フォロー"
      click_on "フォロワー"
      expect(page).to have_content @user.name
    end
  end
end
