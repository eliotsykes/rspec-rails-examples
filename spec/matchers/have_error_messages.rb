module Matchers

  def have_error_messages(*args)
    HaveErrorMessages.new(*args)
  end

  # have_error_message can also be called for clarity
  # when there is only one error message expected.
  alias have_error_message have_error_messages

  class HaveErrorMessages

    attr_accessor :failure_message

    def initialize(*args)
      @expected_messages = *args
    end

    def matches?(actual_page)

      actual_page.within "#error_explanation" do
        
        expected_error_count = @expected_messages.size
        expected_error_count_msg = "#{expected_error_count} #{'error'.pluralize(expected_error_count)} prohibited this user from being saved"

        if !actual_page.has_content? expected_error_count_msg
          self.failure_message = "\nexpected error count message: #{expected_error_count_msg}\n     got error count message: #{actual_page.text}\n"
          return false
        end
        
        actual_page.within "ul" do
          if !actual_page.has_css? "li", count: expected_error_count
            self.failure_message = "\nexpected error count: #{expected_error_count}\n"
            return false
          end

          @expected_messages.each do |expected_msg|
            if !actual_page.has_selector? "li", text: expected_msg
              self.failure_message = "\nmissing error message: #{expected_msg}\n"
              return false
            end
          end
        end

      end

      true
    end

  end

end
