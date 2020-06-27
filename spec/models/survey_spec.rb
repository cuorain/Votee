require 'rails_helper'

RSpec.describe Survey, type: :model do
  before(:each) do
    @user = create(:user)
  end
  context "正しいデータ" do
    it "登録成功" do
      survey = @user.survey.build(question: "好きな食べ物は？")
      expect(survey.valid?).to eq true
    end
  end

  context "不正なデータ" do
    it "空欄" do
      survey = @user.survey.build(question: " ")
      expect(survey.invalid?).to eq true
    end

    it "文字数オーバー" do
      survey = @user.survey.build(question: "a"*257)
      expect(survey.invalid?).to eq true
    end
  end
end
