require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "correct routes check" do
    it "root url" do
      get root_url
      expect(response).to have_http_status(:success)
    end
    it "about url" do
      get about_url
      expect(response).to have_http_status(:success)
    end
  end
end
