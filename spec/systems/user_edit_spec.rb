require 'rails_helper'

RSpec.describe "ユーザ編集", type: :system do
  before(:each) do
    @user = create(:user)
    login(@user)
  end

  describe "編集" do
    context "編集成功" do
      it "情報編集" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        fill_in 'ユーザ名', with: 'edit_test'
        fill_in 'メールアドレス', with: 'edit_test@gmail.com'
        select '女', from: '性別'
        select '愛知県', from: '都道府県'
        attach_file 'プロフィール画像', "#{Rails.root}/spec/factories/test_image2.jpg"
        click_on '変更を保存', class: 'btn'
        expect(page).to have_content 'アカウント情報を変更しました'
      end

      it "パスワード編集" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        click_on "パスワード変更", class: "btn"
        fill_in "新しいパスワード", with: "foobar"
        fill_in "パスワード確認", with: "foobar"
        fill_in "current_password", with: "password"
        click_on "変更を保存", class: "btn"
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end

    context "編集失敗" do
      it "不正なデータ" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        fill_in 'ユーザ名', with: ''
        fill_in 'メールアドレス', with: ''
        select '女', from: '性別'
        select '愛知県', from: '都道府県'
        attach_file 'プロフィール画像', "#{Rails.root}/spec/factories/test_image2.jpg"
        click_on '変更を保存', class: 'btn'
        expect(page).to have_content "エラーがあります"
      end

      it "不正なパスワード" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        click_on "パスワード変更", class: "btn"
        fill_in "新しいパスワード", with: "fooba"
        fill_in "パスワード確認", with: "fooba"
        fill_in "current_password", with: "password"
        click_on "変更を保存", class: "btn"
        expect(page).to have_content "新しいパスワードは６文字以上かつ、パスワード確認と同じ文字列にしてください。"
      end

      it "現在のパスワードが違う" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        click_on "パスワード変更", class: "btn"
        fill_in "新しいパスワード", with: "foobar"
        fill_in "パスワード確認", with: "foobar"
        fill_in "current_password", with: "a"
        click_on "変更を保存", class: "btn"
        expect(page).to have_content "現在のパスワードが違います。"
      end

      it "パスワード確認違う" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        click_on "パスワード変更", class: "btn"
        fill_in "新しいパスワード", with: "foobar"
        fill_in "パスワード確認", with: "aaaaaa"
        fill_in "current_password", with: "password"
        click_on "変更を保存", class: "btn"
        expect(page).to have_content "新しいパスワードは６文字以上かつ、パスワード確認と同じ文字列にしてください。"
      end

      it "パスワード未入力" do
        visit root_path
        find(".dropdown-toggle").click
        click_on "設定", class: "dropdown-item"
        click_on "パスワード変更", class: "btn"
        fill_in "新しいパスワード", with: ""
        fill_in "パスワード確認", with: ""
        fill_in "current_password", with: ""
        click_on "変更を保存", class: "btn"
        expect(page).to have_content "新しいパスワードを入力してください。"
      end

    end
  end

  describe "削除" do
    it "アカウント削除" do
      visit root_path
      find(".dropdown-toggle").click
      click_on "設定", class: "dropdown-item"
      click_on "アカウント削除", class: "btn"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "アカウントを削除しました。"
    end
  end
end
