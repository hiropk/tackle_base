class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    @activation_url = activate_user_url(@user.activation_token)
    mail(
      to: @user.email_address,
      subject: "【Tackle Base】アカウントの有効化のお願い",
      from: %("Tackle Base" <familiar.slj@gmail.com>)
    )
  end
end
