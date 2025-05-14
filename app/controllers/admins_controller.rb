class AdminsController < ApplicationController
  before_action :require_admin

  def dashboard
    # 後で必要な管理者用のデータを取得する
    @total_users = User.count
    @total_active_users = User.where(activated: true).count
    @total_deleted_users = User.where.not(deleted_at: nil).count

    # アクティブユーザーの居住地ごとの内訳を取得
    # residenceが有効な値のものだけを集計
    @residence_stats = User.joins(:profile)
                          .where(activated: true)
                          .where(profiles: { residence: Profile.residences.values })
                          .group("profiles.residence")
                          .count

    # 釣行エリアごとの内訳を取得
    @fishing_area_stats = Profile.where(user_id: User.where(activated: true).select(:id))
                                .pluck(:fishing_areas)
                                .flatten
                                .group_by(&:itself)
                                .transform_values(&:count)

    # 興味のある釣りの内訳を取得
    @interest_fishing_stats = Profile.where(user_id: User.where(activated: true).select(:id))
                                   .pluck(:interest_fishings)
                                   .flatten
                                   .group_by(&:itself)
                                   .transform_values(&:count)
  end

  def mail_form
    params[:residence] ||= [
      Profile.residences["tottori"],  # 鳥取県
      Profile.residences["shimane"],  # 島根県
      Profile.residences["okayama"],  # 岡山県
      Profile.residences["hiroshima"], # 広島県
      Profile.residences["yamaguchi"]  # 山口県
    ]

    params[:fishing_area] ||= [
      Profile::FISHING_AREAS.key("shimane"),   # 島根県
      Profile::FISHING_AREAS.key("tottori"),   # 鳥取県
      Profile::FISHING_AREAS.key("yamaguchi"), # 山口県
      Profile::FISHING_AREAS.key("fukui"),     # 福井県
      Profile::FISHING_AREAS.key("kyoto")      # 京都府
    ]

    # 興味のある釣りのデフォルト値
    params[:interest_fishing] ||= [
      Profile::INTEREST_FISHING_TYPES.key("fishing_type_none"),
      Profile::INTEREST_FISHING_TYPES.key("jigging_offshore"),      # ジギング系 - オフショア
      Profile::INTEREST_FISHING_TYPES.key("light_jigging_slj"),    # ジギング系 - ライトジギング (SLJ)
      Profile::INTEREST_FISHING_TYPES.key("deep_jigging"),         # ジギング系 - ディープジギング
      Profile::INTEREST_FISHING_TYPES.key("shore_jigging"),        # ジギング系 - ショアジギング
      Profile::INTEREST_FISHING_TYPES.key("eging_aoiri"),          # エギング系 - アオリイカ
      Profile::INTEREST_FISHING_TYPES.key("light_eging"),          # エギング系 - ライトエギング（ヤリイカ・ヒイカ）
      Profile::INTEREST_FISHING_TYPES.key("ikametal"),             # エギング系 - イカメタル
      Profile::INTEREST_FISHING_TYPES.key("omorig")                # エギング系 - オモリグ
    ]

    @users = User.where(activated: true)
                 .where(is_admin: false)
                 .includes(:profile)
                 .order(created_at: :desc)

    # 検索条件がある場合
    if search_params.present?
      @users = @users.joins(:profile)

      # 居住地での検索（複数選択対応）
      if search_params[:residence].present?
        residences = Array(search_params[:residence]).reject(&:blank?)
        @users = @users.where(profiles: { residence: residences }) if residences.any?
      end

      # 釣行エリアでの検索（複数選択対応）
      if search_params[:fishing_area].present?
        fishing_areas = Array(search_params[:fishing_area]).reject(&:blank?)
        if fishing_areas.any?
          # いずれかの釣行エリアを含むユーザーを検索（OR条件）
          @users = @users.where("profiles.fishing_areas && ARRAY[?]::integer[]", fishing_areas)
        end
      end

      # 興味のある釣りでの検索（複数選択対応）
      if search_params[:interest_fishing].present?
        interest_fishings = Array(search_params[:interest_fishing]).reject(&:blank?)
        if interest_fishings.any?
          # いずれかの興味のある釣りを含むユーザーを検索（OR条件）
          @users = @users.where("profiles.interest_fishings && ARRAY[?]::integer[]", interest_fishings)
        end
      end
    end
  end

  def send_mail
    if params[:user_ids].blank?
      redirect_to admin_mail_path, alert: "メールを送信できませんでした。送信先ユーザーを選択してください。"
      return
    end

    if params[:subject].blank? || params[:body].blank?
      redirect_to admin_mail_path, alert: "メールを送信できませんでした。件名と本文を入力してください。"
      return
    end

    users = User.where(id: params[:user_ids])
    success_count = 0
    error_count = 0

    # 各ユーザーに個別にメールを送信
    users.each do |user|
      begin
        # deliver_laterを使用して非同期で送信
        AdminMailer.individual_message(user, params[:subject], params[:body], @current_user).deliver_later
        success_count += 1
      rescue => e
        Rails.logger.error "Failed to send email to #{user.email_address}: #{e.message}"
        error_count += 1
      end
    end

    if error_count.zero?
      redirect_to admin_path, notice: "#{success_count}人のユーザーにメールを送信しました。"
    else
      redirect_to admin_path, alert: "メールを送信できませんでした。#{error_count}人への送信に失敗しました。"
    end
  end

  private

  def require_admin
    unless @current_user&.is_admin?
      redirect_to root_path, alert: "管理者以外はアクセスできません。"
    end
  end

  def search_params
    params.permit(residence: [], fishing_area: [], interest_fishing: [])
  end
end
