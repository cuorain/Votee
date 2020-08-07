require 'rails_helper'

RSpec.describe "ユーザ編集" do
  before(:each) do
    @user = create(:user)
    @other = create(:other)
  end

  context "管理者でない他のユーザーによる削除" do
    it "警告" do
      post login_path, params: {session: {email: "aiueo@gmail.com", password: "password"}}
      expect do
        delete user_path(@other)
      end.not_to change(User, :count)
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to root_path
    end
  end

end
