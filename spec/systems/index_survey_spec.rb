require 'rails_helper'

RSpec.feature '投票機能' do
  before(:each) do
    @survey = create(:survey)
    @other_survey = create(:other_survey)
    @voted_survey = create(:voted_survey)
    login(:user)
    vote(@voted_survey)
  end

  context "リンク先" do
    example "自分の作ったアンケートのリンクは結果画面へ" do
      visit surveys_path
      expect(page).to have_link "#{@survey.question}"
      click_on "#{@survey.question}"
      expect(page).to have_content "【投票結果】"
    end
    example "投票したアンケートのリンクは投票画面へ" do
      visit surveys_path
      expect(page).to have_link "#{@voted_survey.question}"
      click_on "#{@voted_survey.question}"
      expect(page).to have_content "【投票結果】"
    end
    example "他人の作ったアンケートのリンクは投票画面へ" do
      visit surveys_path
      click_on "#{@other_survey.question}"
      expect(page).not_to have_content "投票取消"
    end
  end

  context "ログイン時と非ログイン時" do
    example "ログイン時" do
      visit surveys_path
      expect(page).to have_link "#{@survey.question}"
      expect(page).to have_content "未投票"
    end
    example "非ログイン時" do
      click_on "ログアウト"
      visit surveys_path
      expect(page).to have_link "#{@survey.question}"
      expect(page).not_to have_content "未投票"
    end
  end

  context "検索機能" do
    example "正しく検索できているか" do
      visit surveys_path
      fill_in "search", with: "スポーツ"
      click_on "検索"
      expect(page).to have_link "好きなスポーツは？"
      expect(page).not_to have_link "好きなアーティストは？"
    end
    example "該当ない場合、警告文" do
      visit surveys_path
      fill_in "search", with: "プログラミング"
      click_on "検索"
      expect(page).to have_content "該当するアンケートが見つかりません。"
    end
  end
end
