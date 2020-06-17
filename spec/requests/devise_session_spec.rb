require 'rails_helper'

RSpec.describe "#session", type: :request do
  let!(:user){ create(:user) }
  #リクエスト成功
  # フラッシュ表示されるか、ページ遷移で消えるか
  # ログイン失敗でリクエスト成功するか
  describe 'ログイン' do
    context 'パスワードとメールアドレスが正しい' do
      it '正しいリクエスト' do
        post login_path, params: {session: {email: "aiueo@gmail.com", password: "password"}}
        expect(response.status).to eq 200
      end

      it 'フラッシュが表示され、ページ移動すると消える' do
        post login_path, params: {session: {email: "aiueo@gmail.com", password: "password"}}
        expect(flash[:alert]).to be_truthy
        get root_path
        expect(flash[:alert]).to be_falsy
      end
    end

    context 'パスワードかメールアドレスが違う' do
      it 'ログイン失敗' do
        post login_path, params: {session: {email: "", password: ""}}
        expect(response.status).to eq 200
      end

      it 'フラッシュが表示され、ページ移動すると消える' do
        post login_path, params: {session: {email: "", password: ""}}
        expect(flash[:alert]).to be_truthy
        get root_path
        expect(flash[:alert]).to be_falsy
      end
    end
  end

  describe 'ログアウト' do
    it 'リダイレクトされ、ログアウトメッセージ表示' do
      post login_path, params: {session: {email: "aiueo@gmail.com", password: "password"}}
      delete logout_path
      expect(flash[:notice]).to be_truthy
      expect(response).to redirect_to root_path
    end
  end
end
