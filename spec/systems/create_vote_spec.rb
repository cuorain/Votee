require 'rails_helper'

RSpec.feature '投票機能' do
  before(:each) do
    @survey = create(:survey)
    login(:user)
  end

  context "正しい入力" do
    example "フラッシュと遷移先が正しいこと" do
      visit survey_path(@survey)
      check 'りんご'
      fill_in "コメント", with: "特にふじが好き。"
      click_on "投票", class: "btn"
      expect(page).to have_content "投票しました。"
      expect(page).to have_content "投票結果"
    end
  end

  context "入力不備" do
    example "選択肢を選ばないとエラー" do
      visit survey_path(@survey)
      fill_in "コメント", with: "特にふじが好き。"
      click_on "投票", class: "btn"
      expect(page).to have_content "選択してください。"
    end

    example "コメントが長いとエラー" do
      visit survey_path(@survey)
      check 'りんご'
      fill_in "コメント", with: "あ"*257
      click_on "投票", class: "btn"
      expect(page).to have_content "コメントは256文字以内で入力してください。"
    end
  end

  context "結果だけ見る" do
    example "結果画面が表示され、投票リンクがある" do
      visit survey_path(@survey)
      click_on "結果を見る", class: "btn"
      expect(page).to have_content "投票結果"
      expect(page).to have_content "投票する"
    end
  end
end
