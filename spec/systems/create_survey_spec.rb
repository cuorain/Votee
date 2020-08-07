require 'rails_helper'

RSpec.feature 'アンケート作成' do
  before(:each) do
    @user = create(:user)
    login(@user)
  end

  scenario 'アンケート作成成功', js: true do
    visit root_path
    click_on 'アンケート作成', class: "nav-link"
    fill_in '質問', with: '好きな食べ物は？'
    fill_in 'survey[choices_attributes][0][answer]', with: 'そば'
    9.times do |i|
      click_on "選択肢を追加", class: "btn"
    end
    expect(all('.form-row').size).to eq(10)
    all(".form-control").each do |input|
      input.set("ラーメン")
    end
    expect(page).not_to have_content "選択肢を追加"
    click_on '新規アンケート開始', class: 'btn'
    expect(page).to have_content 'アンケートを作成しました'
  end

  scenario '質問空欄', js: true do
    visit root_path
    click_on 'アンケート作成', class: "nav-link"
    fill_in '質問', with: ''
    fill_in 'survey[choices_attributes][0][answer]', with: 'そば'
    click_on '新規アンケート開始', class: 'btn'
    expect(page).to have_content '質問を入力してください'
  end

  scenario "選択肢空欄" do
    visit root_path
    click_on 'アンケート作成', class: "nav-link"
    fill_in '質問', with: '何が好き？'
    fill_in 'survey[choices_attributes][0][answer]', with: ''
    click_on '新規アンケート開始', class: 'btn'
    expect(page).to have_content '選択肢を入力してください'
  end

  scenario "追加した選択肢空欄",js: true do
    visit root_path
    click_on 'アンケート作成', class: "nav-link"
    fill_in '質問', with: '何が好き？'
    fill_in 'survey[choices_attributes][0][answer]', with: 'そば'
    click_on "選択肢を追加", class: "btn"
    expect(all('.form-row').size).to eq(2)
    click_on '新規アンケート開始', class: 'btn'
    expect(page).to have_content '選択肢を入力してください'
  end

  scenario "ログインしないと作成できない" do
    visit root_path
    click_on "ログアウト"
    visit new_survey_path
    expect(page).to have_content 'ログインしてください'
  end

end
