class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirmation(attachment)
    @order = params[:order]
    @tickets = @order.tickets
    @user = params[:user]
    attachments["order_#{@order.id}.pdf"] = File.read(attachment)
    mail(to: @user.email, subject: "Order details")
  end
end
