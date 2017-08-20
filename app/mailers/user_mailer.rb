class UserMailer < ApplicationMailer
  default from: @support_email

  def comment_reply_notification(replying_to, prior_message, message, commenter, comment_parent)
    @replying_to = replying_to
    @prior_message = prior_message
    @message = message
    @commenter = commenter
    @parent = comment_parent
    mail(to: @replying_to.email, subject: "[#{ @email_prefix }] A user replied to your comment.")
  end

  def like_notification(liked_user, message, liker, like_parent)
    @liked_user = liked_user
    @message = message
    @liker = liker
    @parent = like_parent
    mail(to: @liked_user.email, subject: "[#{ @email_prefix }] A user liked your comment.")
  end

  def new_ticket_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: @support_email, subject: "[#{ @email_prefix }] A user submitted a ticket.")
  end

  def ticket_message_user_notification(user, admin, message, ticket, title)
    @user = user
    @message = message
    @admin = admin
    @ticket = ticket
    @title = title
    mail(to: user.email, subject: "[#{ @email_prefix }] Your support ticket has a reply.")
  end

  def ticket_message_admin_notification(user, message, ticket, title)
    @user = user
    @message = message
    @ticket = ticket
    @title = title
    mail(to: @support_email, subject: "[#{ @email_prefix }] A user replied to a ticket.")
  end
end