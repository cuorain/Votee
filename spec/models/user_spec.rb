require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、メールアドレス、パスワードがあれば登録できる
  # 名前空欄だめ
  # 名前65文字以上だめ
  # メールアドレス空欄だめ
  # メールアドレス257文字以上だめ(RFCで定められている)
  # メールアドレスのフォーマット
  # メールアドレスの一意性
  # パスワード６文字以上
  # パスワード確認とパスワード一致

  describe "Userのバリデーション" do
    context "ユーザ" do
      it "存在性" do
        user = build(:new_user, name: "")
        expect(user).not_to be_valid
      end

      it "６５文字未満" do
        user = build(:new_user, name: "a"*65)
        expect(user).not_to be_valid
      end
    end

    context "メールアドレス" do
      it "存在性" do
        user = build(:new_user, email: " ")
        expect(user).not_to be_valid
      end

      it "２５７文字未満" do
        user = build(:new_user, email: "a"*257)
        expect(user).not_to be_valid
      end

      it "正規表現" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user = build(:new_user, email: invalid_address)
          expect(user).not_to be_valid
        end
      end

      it "メールアドレスの一意性" do
        user = create(:new_user)
        user2 = build(:new_user, email: user.email.upcase)
        expect(user2).not_to be_valid
      end
    end

    context "パスワード" do
      it "パスワードが６文字以上" do
        user = build(:new_user, password: "aaaaa", password_confirmation: "aaaaa")
        expect(user).not_to be_valid
      end

      it "パスワード確認が正しい" do
        user = build(:new_user, password: "foobar", password_confirmation: "aaaaaa")
        expect(user).not_to be_valid
      end
    end
  end
end
