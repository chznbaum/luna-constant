class UserMailer < ApplicationMailer
  default from: 'chazona@chazonabaum.com'

  def new_ticket_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: 'chazona@chazonabaum.com', subject: 'A user submitted a ticket.')
  end

  def ticket_message_user_notification(user, admin, message, ticket, title)
    @user = user
    @message = message
    @admin = admin
    @ticket = ticket
    @title = title
    mail(to: user.email, subject: 'Your support ticket has a reply.')
  end

  def ticket_message_admin_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: 'chazona@chazonabaum.com', subject: 'A user replied to a ticket.')
  end
end