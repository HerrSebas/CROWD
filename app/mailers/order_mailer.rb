class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirmation
    @order = params[:order]
    @tickets = @order.tickets
    @user = params[:user]
    @codes = []
    @tickets.each do |ticket|
      code = RQRCode::QRCode.new("https://crowd-912.herokuapp.com/orders/#{ticket.order.id}/tickets/#{ticket.id}")
      png = code.as_png(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )
      @codes.push(png)
    end
    attachments.inline["logo.pdf"] = File.read("#{Rails.root}/app/views/tickets/index.html.erb")
    mail(to: @user.email, subject: "Order details")
  end
end
