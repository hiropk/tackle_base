class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create activate restore_form restore ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_session_path, notice: "あなたのメールアドレス宛にメールを送りました。メールのリンクからアカウントを有効にしてください。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @current_user.update(user_params)
      @current_user.update(activated: false)
      @current_user.activation_token = SecureRandom.urlsafe_base64
      UserMailer.activation_email(@current_user).deliver_later
      terminate_session
      redirect_to new_session_path, notice: "メールアドレスが変更されました。あなたのメールアドレス宛にメールを送りました。メールのリンクからアカウントを有効にしてください。"
    else
      redirect_to edit_user_path(@current_user), alert: "メールアドレスに誤りがあります。"
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:token])
    if @user && !@user.activated
      @user.activate
      redirect_to new_session_path, notice: "あなたのアカウントを有効化しました。ログインをすることによりサービスを利用できます。"
    else
      redirect_to new_user_path, alert: "無効もしくは有効期限書きれたリンクです。"
    end
  end

  def manual_activation
    @current_user.activation_token = SecureRandom.urlsafe_base64
    UserMailer.activation_email(@current_user).deliver_later
    terminate_session
    redirect_to new_session_path, notice: "あなたのメールアドレス宛にメールを送りました。メールのリンクからアカウントを有効にしてください。"
  end

  def deactivate
    @current_user.soft_delete
    terminate_session
    redirect_to new_session_path, notice: "退会処理が完了しました。退会後のログイン画面から復帰することが可能です。ご利用ありがとうございました。"
  end

  def restore_form
  end

  def restore
    if user = User.authenticate_by(params.permit(:email_address, :password))
      if user.deleted?
        user.restore
        redirect_to new_session_path, notice: "アカウントを復帰しました。ログインしてサービスをご利用ください。"
      else
        redirect_to new_session_path, alert: "このアカウントは退会していません。"
      end
    else
      redirect_to restore_form_users_path, alert: "メールアドレスまたはパスワードが正しくありません。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
