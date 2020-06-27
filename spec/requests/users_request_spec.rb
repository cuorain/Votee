require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "登録" do
    # ポストリクエスト成功
    # ユーザー増えてる
    # ユーザーページにリダイレクト
    context '正しいパラメを入力した時' do
      it "ユーザが登録されている" do
        expect do
          post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        end.to change(User, :count).by(1)
      end
      
      it "登録後、ログイン" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        expect(logged_in?).to eq true
      end

      it "ホームへリダイレクト" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user)}
        expect(response.status).to redirect_to(root_path)
      end
    end

    # ポストリクエスト失敗
    # ユーザー増えない
    # 登録ページ再表示
    context '不正なパラメを入力した時' do
      it "ユーザが登録されない(名前ない)" do
        expect do
          post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid)}
        end.not_to change(User, :count)
      end

      it "ユーザが登録されない（パスワード違う）" do
        expect do
          post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid_confirmation)}
        end.not_to change(User, :count)
      end

      it "登録ページにrender" do
        post signup_path, params: {user: FactoryBot.attributes_for(:new_user, :invalid)}
        expect(response.body).to include('エラーがあります')
      end
    end
  end
  describe "GET /index" do
    it "returns http success" do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end
  #
  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/users/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
