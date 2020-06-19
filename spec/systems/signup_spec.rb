require 'rails_helper'

RSpec.feature 'ユーザ登録' do
  scenario 'ユーザ登録' do
    visit root_path
    click_on '新規登録', class: "btn"
    fill_in 'ユーザ名', with: 'test1'
    fill_in 'メールアドレス', with: 'test1@gmail.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード確認', with: 'password'
    select '男', from: '性別'
    select '1997', from: 'user[birthday(1i)]'
    select '5', from: 'user[birthday(2i)]'
    select '5', from: 'user[birthday(3i)]'
    select '東京都', from: '都道府県'
    attach_file 'プロフィール画像', "#{Rails.root}/spec/factories/test_image.jpg"
    click_on '新規ユーザ登録', class: 'btn'
    expect(page).to have_content 'アカウント登録が完了しました'
  end
end
