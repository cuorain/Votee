require 'rails_helper'

RSpec.describe "sitelayout", type: :system do
  describe "home link　check" do
    it "link to home" do
      visit root_path
      expect(page).to have_link 'The survey', href: root_path
      expect(page).to have_link 'ホーム', href: root_path
    end

    # it "link to signup" do
    #   visit root_path
    #   expect(page).to have_link '新規登録', href: signup_path, count: 2
    # end
  end
end
