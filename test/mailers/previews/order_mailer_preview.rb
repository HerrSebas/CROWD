# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/confirmation
  def confirmation
    @user = User.first
    @order = @user.orders.last
    @tickets = @order.tickets
    OrderMailer.with(user: @user, order: @order, tickets: @tickets).confirmation
  end
end
