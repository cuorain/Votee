require 'rails_helper'

RSpec.feature "ユーザ詳細" do
  before(:each) do
    @other_survey = create(:other_survey)
    @voted_survey = create(:voted_survey)
    @user = create(:user)
    @other = @other_survey.user
    login(:user)
    vote(@voted_survey)
  end

  context "ステータス" do
    example "作成したアンケート数が正しい" do
      visit root_path
      expect(page).to have_selector ".survey-count", text: "0"
      visit user_path(@other)
      expect(page).to have_selector ".survey-count", text: "1"
    end
    example "投票したアンケート数が正しい" do
      visit root_path
      expect(page).to have_selector ".voted-count", text: "1"
      visit user_path(@other)
      expect(page).to have_selector ".voted-count", text: "0"
    end
  end

  context "アンケート" do
    example "作成したアンケートが表示されている" do
      visit root_path
      expect(page).not_to have_content "#{@other_survey.question}"
      visit user_path(@other)
      expect(page).to have_content "#{@other_survey.question}"
    end
    example "投票したアンケートが表示されている" do
      visit root_path
      expect(page).to have_content "#{@voted_survey.question}"
      visit user_path(@other)
      expect(page).not_to have_content "#{@voted_survey.question}"
    end
  end

  context "検索" do
    example "検索機能が作成側と投票側で独立していること" do
      visit user_path(@other)
      fill_in "voted_search", with: "スポーツ" #作成した側に質問ある。投票側はない
      within ".voted-survey" do
        click_on "検索"
      end
      expect(page).to have_content "#{@other_survey.question}" #投票側で検索したので、作成側は関係ない
      fill_in "voted_search", with: "アーティスト"
      within ".voted-survey" do
        click_on "検索"
      end
      expect(page).to have_content "#{@other_survey.question}" #投票側で検索したので、作成側は関係ない
      fill_in "my_search", with: "アーティスト"
      within ".my-survey" do
        click_on "検索"
      end
      expect(page).to have_content "該当するアンケートが見つかりません。", count: 2
    end
  end
end
