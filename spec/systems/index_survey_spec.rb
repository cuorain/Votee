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
      expect(page).to have_content "【新規投票】"
    end
  end
end
