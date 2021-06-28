class DeleteExpiredEventsJob < ApplicationJob
  queue_as :default

  def perform
    if Event.where(['end_date < ?', Date.current])
      Event.expired_events.delete_all
      sleep 2
    end
  end
end
