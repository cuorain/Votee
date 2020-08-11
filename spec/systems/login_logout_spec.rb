require 'rails_helper'

RSpec.feature 'ログインとログアウト' do
  background do
    @user = create(:user)
  end
  scenario 'ログイン成功' do
    visit root_path
    find(".btn-info").click
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン', class: 'btn'
    expect(page).to have_content 'ログインしました'
  end

  scenario 'ログイン失敗' do
    visit root_path
    find(".btn-info").click
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'invalid'
    click_on 'ログイン', class: 'btn'
    expect(page).to have_content 'メールアドレスかパスワードが違います'
  end

  scenario 'ログアウト' do
    visit root_path
    find(".btn-info").click
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン', class: 'btn'
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario "ログイン状態だと入れないようにする" do
    login(:user)
    visit login_path
    expect(page).to have_content "すでにログインしています。"
    expect(page).to have_content "#{@user.name}"
  end
end
