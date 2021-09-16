class WageUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    sleep(20)
    wage_percent_add = args[0]
    User.all.each do |user|
      user.wage += user.wage * (wage_percent_add / 100)
      user.save
    end
  end
end
