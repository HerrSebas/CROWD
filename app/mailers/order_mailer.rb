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

  def pdf_attachment_method
    todo = Todo.find(6)
    attachments["todo_#{todo.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'todo', template: 'todo.pdf.erb', layout: 'pdf.html'), { :hash_with_wickedpdf_options }
    )
    mail(to: todo.owner.email, subject: 'Your todo PDF is attached', todo: todo)
  end
end
end
