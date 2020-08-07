require 'rails_helper'

RSpec.feature 'アンケート編集・削除' do
  before(:each) do
    @survey = create(:survey)
    @other_survey = create(:other_survey)
    @admin = create(:admin)
    login(:user)
  end

  context "正しい入力" do
    example "編集が成功する" do
      visit survey_path(@survey)
      click_on "アンケートの編集"
      fill_in 'survey[choices_attributes][0][answer]', with: 'マンゴー'
      click_on 'アンケート更新', class: 'btn'
      expect(page).to have_content 'アンケートを編集しました'
      expect(page).to have_content 'マンゴー'
    end
  end

  context "入力に不備" do
    example "エラーになる" do
      visit survey_path(@survey)
      click_on "アンケートの編集"
      fill_in 'survey[choices_attributes][0][answer]', with: ' '
      click_on 'アンケート更新', class: 'btn'
      expect(page).to have_content '選択肢を入力してください'
      expect(page).to have_content '【編集】'
    end
  end

  context "他人の編集禁止" do
    example "編集ボタンがない" do
      visit survey_path(@other_survey)
      expect(page).not_to have_content 'アンケートの編集'
    end
    example "編集禁止" do
      visit edit_survey_path(@other_survey)
      expect(page).to have_content '不正なユーザーです。'
    end
  end

  context "アンケート削除", js: true do
    example "削除が成功する" do
      visit survey_path(@survey)
      click_on "アンケートの編集"
      page.accept_confirm do
        click_on 'アンケート削除'
      end
      expect(page).to have_content 'アンケートを削除しました'
      expect(page).to have_content 'アンケート検索'
    end
    #他人の削除を禁止するのはrequestスペックへ
  end

  context "管理者による編集" do
    example "編集" do
      click_on "ログアウト"
      admin_login(@admin)
      visit survey_path(@survey)
      click_on "アンケートの編集"
      fill_in 'survey[choices_attributes][0][answer]', with: 'マンゴー'
      click_on 'アンケート更新', class: 'btn'
      expect(page).to have_content 'アンケートを編集しました'
      expect(page).to have_content 'マンゴー'
    end

    example "削除" do
      click_on "ログアウト"
      admin_login(@admin)
      visit survey_path(@survey)
      click_on "アンケートの編集"
      click_on 'アンケート削除'
      expect(page).to have_content 'アンケートを削除しました'
      expect(page).to have_content 'アンケート検索'
    end
  end
end
