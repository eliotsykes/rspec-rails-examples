module ApplicationHelper

  attr_writer :page_title

  def page_title
    @page_title ||= "RSpec Rails Examples"
  end
  
end
