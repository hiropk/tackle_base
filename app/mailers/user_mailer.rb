class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    @activation_url = activate_user_url(@user.activation_token)
    mail(to: @user.email_address, subject: "アカウントを有効化してください。")
  end
end
