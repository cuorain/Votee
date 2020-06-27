require 'rails_helper'

RSpec.describe "static_pages", type: :system do
  describe "ログインの有無" do
    include SessionsHelper
    context "ログインしてない時" do
      it "リンクがあるか" do
        visit root_path
        expect(page).to have_link 'The survey', href: root_path
        expect(page).to have_link 'ホーム', href: root_path
        #expect(page).to have_link 'アンケート一覧', href:
        expect(page).to have_link '新規登録', href: signup_path
        expect(page).to have_link 'ログイン', href: login_path
      end
    end

    context "ログインしてる時" do
      before(:each) do
        @user = create(:user)
        login(@user)
      end
      it "リンクがあるか" do
        visit root_path
        expect(page).to have_link 'The survey', href: root_path
        expect(page).to have_link 'ホーム', href: root_path
        #expect(page).to have_link 'アンケート一覧', href:
        #expect(page).to have_link 'アンケート作成', href:
        #expect(page).to have_link 'タイムライン', href:
        find(".dropdown-toggle").click
        expect(page).to have_link 'ユーザ検索', href: users_path
        expect(page).to have_link '設定', href: edit_user_path(@user)
        expect(page).to have_link 'ログアウト', href: logout_path
      end
      it "ユーザ情報が正しいか" do
        visit root_path
        expect(page).to have_selector "div.user-status", text: @user.name
      end
    end

  end
end
