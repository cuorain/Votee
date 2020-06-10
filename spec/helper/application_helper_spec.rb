require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title" do
    context "page title is empty" do
      it "| remove" do
        expect(helper.full_title).to eq('The survey')
      end
    end
    context "page title is not empty" do
      it "home" do
        expect(helper.full_title('Home')).to eq('Home | The survey')
      end
      it "about" do
        expect(helper.full_title('About')).to eq('About | The survey')
      end
    end
  end
end
