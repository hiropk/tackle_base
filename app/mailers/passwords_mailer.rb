class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail(
      to: user.email_address,
      subject: "【Tackle Base】パスワード再設定のご案内",
      from: %("Tackle Base" <familiar.slj@gmail.com>)
    )
  end
end
