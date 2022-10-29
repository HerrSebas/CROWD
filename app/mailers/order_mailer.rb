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
    mail(to: @user.email, subject:  "Order details")
  end
end
