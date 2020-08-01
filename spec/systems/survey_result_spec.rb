require 'rails_helper'

RSpec.feature 'アンケート結果' do
  before(:each) do
    @survey = create(:survey)
    login(:user)
  end

  context "正しく結果が表示される" do
    example "投票結果が反映されている" do
      vote(@survey)
      visit survey_result_path(@survey)
      expect(page).to have_selector "table"
      expect(all("th")[0].text).to eq "りんご"
      expect(all("th")[1].text).to eq "ブルーベリー"
      expect(all("th")[2].text).to eq "バナナ"
      expect(all("th")[3].text).to eq "みかん"
      expect(all("th")[4].text).to eq "1"
      expect(all("th")[5].text).to eq "0"
      expect(all("th")[6].text).to eq "0"
      expect(all("th")[7].text).to eq "0"
      expect(page).not_to have_content "投票がされていません。"
    end

    example "投票がない時にアラート" do
      visit survey_result_path(@survey)
      expect(page).to have_content "投票がされていません。"
      expect(page).not_to have_selector "table"
    end
  end

  context "ログイン" do
    example "ログインしている時の結果" do
      visit survey_result_path(@survey)
      expect(page).not_to have_content "投票するにはアカウントが必要です。"
    end

    example "ログインしていない時投票できない" do
      click_on "ログアウト"
      visit survey_result_path(@survey)
      expect(page).to have_content "投票するにはアカウントが必要です。"
      expect(page).to have_link "新規登録", count: 2
      expect(page).to have_link "ログイン", count: 2
    end
  end
end
