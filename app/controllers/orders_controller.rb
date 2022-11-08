class OrdersController < ApplicationController
  #before_action :set_event, only: %i[show edit update]

  def index
    @orders = Order.where(user: current_user)
  end

  def show
    @order = Order.find(params[:id])
    @tickets = @order.tickets
    @codes = []
    @tickets.each do |ticket|
      code = RQRCode::QRCode.new("https://crowd-912.herokuapp.com/orders/#{ticket.order.id}/tickets/#{ticket.id}")
      png = code.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: "black",
        file: nil,
        fill: "white",
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 120
      )
      IO.binwrite("/tmp/github-qrcode.png", png.to_s)
      @codes.push(png)
    end
    respond_to do |format|
      format.html
      format.pdf { render template: "orders/resumen", pdf: "#{@order.id}" }
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @event = Event.find(params[:event_id])
    @order.user = current_user
    @order.total_price = @event.event_price * @order.tickets_quantity
    if @order.save
      @order.tickets_quantity.times do
        ticket = Ticket.new
        ticket.event = @event
        ticket.user = current_user
        ticket.order = @order
        ticket.ticket_price = @event.event_price
        ticket.save
      end
      @tickets = @order.tickets
      @codes = []
      @tickets.each do |ticket|
        code = RQRCode::QRCode.new("https://crowd-912.herokuapp.com/orders/#{ticket.order.id}/tickets/#{ticket.id}")
        svg = code.as_svg(
          color: "000",
          shape_rendering: "crispEdges",
          module_size: 11,
          standalone: true,
          use_path: true
        )
        @codes.push(svg)
      end

      mail = OrderMailer.with(user: current_user, order: @order, tickets: @order.tickets).confirmation
      mail.deliver_now
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
