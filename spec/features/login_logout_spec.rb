require 'rails_helper'

RSpec.feature 'ログインとログアウト' do
  background do
    create(:user)
  end
  scenario 'ログイン' do
    visit root_path
    click_on 'ログイン'
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン', class: 'btn'
    expect(page).to have_content 'ログインしました'
  end

  scenario 'ログアウト' do
    visit root_path
    click_on 'ログイン'
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン', class: 'btn'
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end
end
