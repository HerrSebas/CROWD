class TicketsController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @tickets = Ticket.where(user: current_user)
  end

  def show
  end

  def new
    @ticket = Ticket.new
    @event = Event.find(params[:event_id])
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @event = Event.find(params[:flat_id])
    @ticket.event = @event
    @ticket.user = current_user
    authorize @ticket
    if @ticket.save
      redirect_to new_event_ticket_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to event_ticket_path, status: :see_other
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:event_id, :user_id, :order_id, :ticket_price)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
