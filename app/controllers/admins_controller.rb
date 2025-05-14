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

  private

  def require_admin
    unless @current_user&.is_admin?
      redirect_to root_path, alert: "管理者以外はアクセスできません。"
    end
  end
end
