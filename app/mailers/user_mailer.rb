class UserMailer < ApplicationMailer
  default from: 'chazona@chazonabaum.com'

  def comment_reply_notification(replying_to, prior_message, message, commenter, comment_parent)
    @replying_to = replying_to
    @prior_message = prior_message
    @message = message
    @commenter = commenter
    @parent = comment_parent
    mail(to: @replying_to.email, subject: '[LunaConstant.com] A user replied to your comment.' )
  end

  def new_ticket_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: 'chazona@chazonabaum.com', subject: '[LunaConstant.com] A user submitted a ticket.')
  end

  def ticket_message_user_notification(user, admin, message, ticket, title)
    @user = user
    @message = message
    @admin = admin
    @ticket = ticket
    @title = title
    mail(to: user.email, subject: '[LunaConstant.com] Your support ticket has a reply.')
  end

  def ticket_message_admin_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: 'chazona@chazonabaum.com', subject: '[LunaConstant.com] A user replied to a ticket.')
  end
end