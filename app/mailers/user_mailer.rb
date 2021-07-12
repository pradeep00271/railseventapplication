class UserMailer < ApplicationMailer
  def signup_email(event_id)
    @event = Event.find(event_id)
    attachments['event1.jpg'] = File.read(Rails.root + 'app/assets/images/event1.jpg')
    mail(to: @event.user.email, subject: 'Alert Email')
  end
  end

