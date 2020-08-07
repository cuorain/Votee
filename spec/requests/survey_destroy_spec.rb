require 'rails_helper'

RSpec.describe "アンケート削除" do
  before(:each) do
    @survey = create(:survey)
    @other_survey = create(:other_survey)
  end

  context "管理者でない他のユーザーによる削除" do
    it "警告" do
      post login_path, params: {session: {email: "aiueo@gmail.com", password: "password"}}
      expect do
        delete survey_path(@other_survey)
      end.not_to change(Survey, :count)
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to root_path
    end
  end

end
