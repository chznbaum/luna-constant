class TicketMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  before_action :authenticate_user!
  def create
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.status != "Closed"
      if @ticket.ticket_messages.create(ticket_message_params)
        user = User.find(@ticket.user_id)
        message = ticket_message_params[:message]
        ticket = @ticket
        title = @ticket.title
        if user != current_user
          admin = User.find(ticket_message_params[:user_id])
          UserMailer.ticket_message_user_notification(user, admin, message, ticket, title).deliver_now
        else
          UserMailer.ticket_message_admin_notification(user, message, ticket, title).deliver_now
        end
        redirect_to ticket_path(params[:ticket_id]), notice: "Your message was posted."
      else
        flash.alert = "Error! Please try again."
        redirect_to @ticket
      end
    else
      flash.alert = "The ticket is closed!"
      redirect_to @ticket
    end
  end

  private

  def ticket_message_params
    params.require(:ticket_message).permit(:user_id, :message, :ticket_id)
  end
end