require 'rails_helper'

RSpec.feature '投票編集' do
  before(:each) do
    @survey = create(:survey)
    login(:user)
    vote(@survey)
  end

  context "正しい編集" do
    example "投票が反映されていて,編集が成功している" do
      visit survey_path(@survey)
      expect(page).to have_checked_field("りんご")
      uncheck "りんご"
      check "ブルーベリー"
      click_on "投票", class: "btn"
      expect(page).to have_content "投票修正しました。"
      expect(page).to have_content "投票結果"
      click_on "投票修正", class: "btn"
      expect(page).to have_checked_field("ブルーベリー")
    end
  end

  context "不正なパラメで編集" do
    example "投票が反映されていて、エラーが出る" do
      visit survey_path(@survey)
      expect(page).to have_checked_field("りんご")
      uncheck "りんご"
      click_on "投票", class: "btn"
      expect(page).to have_content "選択してください。"
      expect(page).to have_content "投票修正"
      expect(page).to have_checked_field("りんご")
    end
  end

  context "投票取り消し" do
    example "投票が取り消されている" do
      visit survey_path(@survey)
      click_on "投票取消", class: "btn"
      expect(page).to have_content "投票を取り消しました"
      expect(page).to have_content "投票結果"
      click_on "投票する", class: "btn"
      expect(page).to have_content "新規投票"
    end
  end
  #二重投票不可はmodelへ
end
