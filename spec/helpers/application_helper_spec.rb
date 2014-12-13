require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  
  context "page_title attribute" do
    
    it "has getter and setter" do
      helper.page_title = "About Page Title"
      expect(helper.page_title).to eq("About Page Title")
    end

    it "has sensible default" do
      expect(helper.page_title).to eq("RSpec Rails Examples")
    end

  end

end
