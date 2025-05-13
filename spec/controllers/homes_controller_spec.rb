require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  describe 'GET #index' do
    let(:rss_feed) { File.read('spec/fixtures/rss_sample.xml') }
    let(:feed_entries) { [ double('Entry1'), double('Entry2'), double('Entry3') ] }
    let(:user) { create(:user, activated: true) }
    let(:session) { create(:session, user: user) }

    before do
      # セッションを設定してログイン状態をシミュレート
      cookies.signed[:session_id] = session.id

      # Current.userを設定
      allow(Current).to receive(:session).and_return(session)
      allow(Current).to receive(:user).and_return(user)

      # @current_userを設定
      controller.instance_variable_set(:@current_user, user)

      # モックの設定
      allow(URI).to receive(:open)
        .with('https://rssblog.ameba.jp/familiar-matsue/rss.html')
        .and_return(StringIO.new(rss_feed))

      allow(Feedjira).to receive(:parse).and_return(double(entries: feed_entries))

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

    it 'RSSフィードを取得すること' do
      get :index
      expect(assigns(:feed)).to eq(feed_entries.first(3))
    end

    it '正しいテンプレートがレンダリングされること' do
      get :index
      expect(response).to render_template :index
    end
  end
end
