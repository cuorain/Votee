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

  describe "user validation" do
    it "username presence" do
      user = build(:new_user, name: "")
      expect(user).not_to be_valid
    end

    it "username length is not too long" do
      user = build(:new_user, name: "a"*65)
      expect(user).not_to be_valid
    end

    it "email presence" do
      user = build(:new_user, email: " ")
      expect(user).not_to be_valid
    end

    it "email length is not too long" do
      user = build(:new_user, email: "a"*257)
      expect(user).not_to be_valid
    end

    it "email format is right" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user = build(:new_user, email: invalid_address)
        expect(user).not_to be_valid
      end
    end

    it "email should be unique" do
      user = create(:new_user)
      user2 = build(:new_user, email: user.email.upcase)
      expect(user2).not_to be_valid
    end

    it "password length is 6 min." do
      user = build(:new_user, password: "aaaaa", password_confirmation: "aaaaa")
      expect(user).not_to be_valid
    end

    it "password and password_confirmation must be match" do
      user = build(:new_user, password: "foobar", password_confirmation: "aaaaaa")
      expect(user).not_to be_valid
    end
  end
end
