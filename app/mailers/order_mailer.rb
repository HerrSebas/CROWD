class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirmation
    @user = User.first
    mail(to: @user.email, subject: 'Welcome to CROWD')
  end
end
