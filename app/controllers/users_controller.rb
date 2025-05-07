class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create activate ]
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

  def activate
    @user = User.find_by(activation_token: params[:token])
    if @user && !@user.activated
      @user.activate
      redirect_to new_session_path, notice: "あなたのアカウントを有効化しました。ログインをすることによりサービスを利用できます。"
    else
      redirect_to new_user_path, alert: "無効もしくは有効期限書きれたリンクです。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
