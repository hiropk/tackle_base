require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:admin) { create(:user, activated: true, is_admin: true) }
  let(:admin_session) { create(:session, user: admin) }
  let(:admin_profile) { create(:profile, user: admin) }

  let(:user) { create(:user, activated: true, is_admin: false) }
  let(:session) { create(:session, user: user) }
  let(:profile) { create(:profile, user: user) }

  describe "GET #dashboard" do
    shared_examples "before_actions" do
      before do
        allow(controller).to receive(:set_tackles)
        allow(controller).to receive(:set_rods)
        allow(controller).to receive(:set_reels)
        allow(controller).to receive(:set_lines)
        allow(controller).to receive(:set_leaders)
      end
    end

    context "管理者の場合" do
      include_examples "before_actions"

      before do
        cookies.signed[:session_id] = admin_session.id
        allow(Current).to receive(:session).and_return(admin_session)
        allow(Current).to receive(:user).and_return(admin)
        controller.instance_variable_set(:@current_user, admin)
      end

      it "ダッシュボードが表示されること" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end

    context "非管理者の場合" do
      include_examples "before_actions"

      before do
        cookies.signed[:session_id] = session.id
        allow(Current).to receive(:session).and_return(session)
        allow(Current).to receive(:user).and_return(user)
        controller.instance_variable_set(:@current_user, user)
      end

      it "ルートページにリダイレクトされること" do
        get :dashboard
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("管理者以外はアクセスできません。")
      end
    end
  end
end
