require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "タイトル表示" do
    context "ホーム画面の時" do
      it "| が表示されないこと" do
        expect(helper.full_title).to eq('The survey')
      end
    end
    context "タイトルがprovideされている時" do
      it "home" do
        expect(helper.full_title('Home')).to eq('Home | The survey')
      end
      it "about" do
        expect(helper.full_title('About')).to eq('About | The survey')
      end
    end
  end
end
