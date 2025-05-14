# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer_mailer
class AdminMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer_mailer/admin_message
  def admin_message
    AdminMailer.admin_message
  end

end
