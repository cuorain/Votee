require 'rails_helper'

RSpec.feature 'アンケート編集・削除' do
  before(:each) do
    @survey = create(:survey)
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
  end
end
