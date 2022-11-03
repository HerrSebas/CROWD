class OrdersController < ApplicationController
  #before_action :set_event, only: %i[show edit update]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
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
      pdf = WickedPdf.new.pdf_from_string(
        render_to_string('orders/resumen.pdf.erb', layout: 'pdf.html.erb'),
      )

      attachment = pdf
      mail = OrderMailer.with(user: current_user, order: @order, tickets: @order.tickets).confirmation(attachment)
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
