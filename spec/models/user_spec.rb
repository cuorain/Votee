require 'rails_helper'

RSpec.describe User, type: :model do
  context "正しいデータ" do
    it "登録成功" do
      user = User.new(name: "ryohei", email: "abcdefg@gmail.com",
          password: "foobar", password_confirmation: "foobar",
          sex: "1", birthday: 1990-1-1, prefecture_code: 1)
      expect(user.valid?).to eq true
    end
  end

  context "間違ったデータ" do
    before(:each) do
      @user = create(:user)
    end
    it "名前なし" do
      @user.name = " "
      expect(@user.valid?).to eq false
    end

    it "名前６４文字オーバー" do
      @user.name = "a" * 65
      expect(@user.valid?).to eq false
    end

    it "メールアドレスなし" do
      @user.email = "a" * 65
      expect(@user.valid?).to eq false
    end

    it "メールアドレス２５６文字オーバー" do
      @user.email = "a" * 247 + "@" + "gmail.com"
      expect(@user.valid?).to eq false
    end

    it "メールアドレス正規表現" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to eq false
      end
    end

    it "メールアドレスダブり" do
      @user.email = "aiueo@gmail.com"
      @user2 = User.new(name: "ryohei", email: "aiueo@gmail.com",
          password: "foobar", password_confirmation: "foobar")
      expect(@user2.valid?).to eq false
    end

    it "パスワードなし" do
      @user.password = @user.password_confirmation = "      "
      expect(@user.valid?).to eq false
    end

    it "パスワード５文字以下" do
      @user.password = @user.password_confirmation = "aaaaa"
      expect(@user.valid?).to eq false
    end

    it "パスワード確認" do
      @user.password = "foobar"
      @user.password_confirmation = "aaaaaa"
      expect(@user.valid?).to eq false
    end
  end
end
