class OrdersController < ApplicationController
  #before_action :set_event, only: %i[show edit update]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @event = Event.find(params[:event_id])
    @order.user = current_user
    if @order.save
      @order.tickets_quantity.times do
        ticket = Ticket.new
        ticket.event = @event
        ticket.user = current_user
        ticket.order = @order
        ticket.ticket_price = @event.event_price
        ticket.save
      end
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path, status: :see_other
  end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :order_status, :user_id, :tickets_quantity)
  end

end
