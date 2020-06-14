require 'rails_helper'

RSpec.describe 'user registration', type: :request do
  describe "signup" do
    # ポストリクエスト成功
    # ユーザー増えてる
    # ユーザーページにリダイレクト
    context 'parameter is right' do
      it "request success" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        expect(response.status).to eq 302
      end

      it "user count" do
        expect do
          post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        end.to change(User, :count).by(1)
      end

      it "redirect to user page" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        expect(response.status).to redirect_to(User.last)
      end
    end

    # ポストリクエスト失敗
    # ユーザー増えない
    # 登録ページ再表示
    context 'parameter is NOT right' do
      it "request failed" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid)}
        expect(response.status).to eq 200
      end

      it "user count is same" do
        expect do
          post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid)}
        end.not_to change(User, :count)
      end

      it "redirect to registration" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid)}
        expect(response.body).to include('エラーがあります')
      end
    end
  end
end
