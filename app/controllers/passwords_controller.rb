class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end
    terminate_session
    redirect_to new_session_path, notice: "パスワード再設定用のメールを送信しましたのでご確認ください。"
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "パスワードが変更されました。"
    else
      redirect_to edit_password_path(params[:token]), alert: "パスワードが違います。"
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "パスワード再設定用のリンクの有効期限が切れました。"
    end
end
