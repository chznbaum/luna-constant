class TicketsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :set_ticket, only: [:edit, :open_ticket, :close_ticket]
  before_action :authenticate_user!
  access all: [], user: [:index, :new, :create, :show], helper: :all, site_admin: :all

  def index
    if current_user.has_role?(:site_admin, :helper)
      @tickets = Ticket.all.order('status DESC', 'created_at DESC')
    else
      @tickets = current_user.tickets.order('status DESC', 'created_at DESC')
    end
    @ticket = Ticket.new
    @ticket.ticket_messages.build
  end

  def new
    @ticket = Ticket.new
    @ticket.ticketmessages.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      user_id = ticket_params[:user_id]
      user = User.find_by(id: user_id)
      message = ticket_params[:ticket_messages_attributes]["0"][:message]
      ticket = @ticket
      title = ticket_params[:title]
      UserMailer.new_ticket_notification(user, message, ticket, title).deliver_now
      flash.notice = "Ticket created successfully!"
      redirect_to ticket_path(@ticket.id)
    else
      flash.alert = "Error! Ticket was not created!"
      render 'index'
    end
  end

  def show
    @ticket = Ticket.includes(:ticket_messages).find(params[:id])
    if current_user === @ticket.user || current_user.has_role?(:site_admin, :helper)
      @messages = @ticket.ticket_messages.order('created_at ASC')
      @message = TicketMessage.new
    else
      flash.alert = "No such ticket."
      redirect_to tickets_path
    end
  end

  def open_ticket
    if @ticket.status == 'Closed'
      @ticket.update(status:'Open')
      @ticket.save!
      redirect_to tickets_path
    end
  end

  def close_ticket
    if @ticket.status != 'Closed'
      @ticket.update(status: 'Closed')
      @ticket.save!
      redirect_to tickets_path
    end
  end      

  private

  def set_ticket
      @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :user_id, :status, ticket_messages_attributes: [:message, :user_id, :ticket_id])
  end

end