require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "リンクが正しいか" do
    context 'ログイン前' do
      it "ホーム" do
        get root_url
        expect(response).to have_http_status(:success)
      end
      it "アバウト" do
        get about_url
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログイン後' do
      before do
        user = create(:user)
        post login_path, params: {session: {email: user.email, password: user.password}}
      end
    end
  end
end
