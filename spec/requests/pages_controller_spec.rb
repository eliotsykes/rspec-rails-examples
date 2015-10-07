require "rails_helper"

RSpec.describe "Pages Controller", type: :request do

  context "Index" do

    it "redirects to index page" do
      get "/"
      expect(response).to have_http_status(:success)

      expect(response).to render_template(:index)
      expect(response.body).to include("Welcome to RSpec Rails Examples")
    end

  end

  context "Share" do

    it "redirect to share page" do
      get "/share"
      expect(response).to have_http_status(:success)

      expect(response).to render_template(:share)
      expect(response.body).to include("Share Our Stuff!")
    end

  end

end
