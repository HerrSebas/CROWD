class OrdersController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(event_params)
    if @order.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to lists_path, status: :see_other
  end

  def edit
  end

  def update
    if @order.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:order).permit(:total_price, :order_status, :user_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
