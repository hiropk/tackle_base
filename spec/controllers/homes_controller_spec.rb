require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user, activated: true) }
    let(:session) { create(:session, user: user) }
    let(:profile) { create(:profile, user: user, last_name: "山田", first_name: "太郎", residence: :tokyo, fishing_areas: [ 13 ], interest_fishings: [ 1 ]) }

    context 'when user is authenticated and activated with completed profile' do
      before do
        # セッションを設定してログイン状態をシミュレート
        cookies.signed[:session_id] = session.id

        # Current.userを設定
        allow(Current).to receive(:session).and_return(session)
        allow(Current).to receive(:user).and_return(user)

        # @current_userを設定
        controller.instance_variable_set(:@current_user, user)

        # プロフィールを作成
        profile

        # before_actionのスタブ
        allow(controller).to receive(:set_tackles)
        allow(controller).to receive(:set_rods)
        allow(controller).to receive(:set_reels)
        allow(controller).to receive(:set_lines)
        allow(controller).to receive(:set_leaders)
      end

      it 'リクエストが成功すること' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it '正しいテンプレートがレンダリングされること' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'when user is not activated' do
      let(:inactive_user) { create(:user, activated: false) }
      let(:inactive_session) { create(:session, user: inactive_user) }

      before do
        cookies.signed[:session_id] = inactive_session.id
        allow(Current).to receive(:session).and_return(inactive_session)
        allow(Current).to receive(:user).and_return(inactive_user)
        controller.instance_variable_set(:@current_user, inactive_user)
      end

      it 'プロフィールページにリダイレクトされること' do
        get :index
        expect(response).to redirect_to(user_profile_path(inactive_user))
      end
    end

    context 'when profile setup is not completed' do
      let(:incomplete_profile) { create(:profile, user: user, last_name: "ユーザ名", first_name: "ユーザ名", residence: :shimane, fishing_areas: [ 0 ], interest_fishings: [ 0 ]) }

      before do
        cookies.signed[:session_id] = session.id
        allow(Current).to receive(:session).and_return(session)
        allow(Current).to receive(:user).and_return(user)
        controller.instance_variable_set(:@current_user, user)
        incomplete_profile
      end

      it 'プロフィール編集ページにリダイレクトされること' do
        get :index
        expect(response).to redirect_to(edit_user_profile_path(user))
      end
    end
  end
end
