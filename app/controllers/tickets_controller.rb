class TicketsController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(event_params)
    if @ticket.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to lists_path, status: :see_other
  end

  def edit
  end

  def update
    if @ticket.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:ticket).permit(:event_id, :user_id, :order_id, :ticket_price)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
