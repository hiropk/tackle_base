class AdminMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.admin_message.subject
  #
  def individual_message(user, subject, body, admin_user)
    @user = user
    @body = body
    @admin_user = admin_user

    mail(
      to: @user.email_address,
      subject: subject,
      from: "タックルベース管理者 <#{@admin_user.email_address}>",
      # BCCで送信者にも控えを送る
      bcc: @admin_user.email_address
    )
  end
end
