require 'rails_helper'

RSpec.describe "編集リクエストチェック" do
  describe "編集ページ" do
    before do
      @user = create(:user)
      @other = create(:other)
    end
    context "ログインしている" do
      it "情報編集ページ" do
        sign_in @user
        get edit_user_registration_path(@user)
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない" do
      it "情報編集ページ" do
        get edit_user_registration_path(@user)
        expect(response.status).to eq 401
        expect(response.body).to include "アカウント登録もしくはログインしてください。"
      end
    end
  end

  describe "編集アクション" do

  end
end
