require 'rails_helper'

RSpec.describe "Subscription tasks", :type => :task do

  context "subscription:confirmation_overdue:delete" do

    it "leaves unconfirmed subscriptions of age 3 days or younger" do
      not_overdue = create_list(:subscription, 2, created_at: 3.days.ago)
      expect { invoke_task }.to change { Subscription.count }.by(0)
    end

    it "deletes unconfirmed subscriptions of age more than 3 days" do
      overdue = create_list(:subscription, 2, created_at: (3.days.ago + 1.second))
      expect { invoke_task }.to change { Subscription.count }.from(2).to(0)
    end

    xit "ends gracefully when no subscriptions exist" do
    end

    xit "leaves confirmed subscriptions alone" do
    end

    private

    def invoke_task
      task = Rake::Task["subscription:confirmation_overdue:delete"]
      # Ensure task is re-enabled, as rake tasks by default are disabled 
      # after running once within a process http://pivotallabs.com/how-i-test-rake-tasks/
      task.reenable
      task.invoke
    end

  end

end
