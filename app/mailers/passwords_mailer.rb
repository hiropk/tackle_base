class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "パスワードを再設定してください", to: user.email_address
  end
end
