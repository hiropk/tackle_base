require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:tackle) { create(:tackle, user: user) }
  let(:valid_attributes) {
    {
      log: {
        fishing_date: Date.current,
        start_time: Time.current,
        end_time: Time.current + 4.hours,
        area: "Tokyo Bay",
        fishing_guide_boat: false,
        menu: "seabass",
        notes: "Test log",
        other: "Other notes",
        tackle_ids: [ tackle.id ]
      }
    }
  }

  let(:invalid_attributes) {
    {
      log: {
        fishing_date: nil,
        start_time: nil,
        end_time: nil,
        area: "",
        fishing_guide_boat: nil,
        menu: nil,
        notes: nil,
        other: nil,
        tackle_ids: []
      }
    }
  }

  before do
    # セッションを作成
    @session = user.sessions.create!(
      user_agent: 'Rails Testing',
      ip_address: '0.0.0.0'
    )

    # Current.sessionとCurrent.userをセット
    allow(Current).to receive(:session).and_return(@session)
    allow(Current).to receive(:user).and_return(user)

    # Cookieをセット
    cookies.signed[:session_id] = @session.id

    # 認証関連のフィルターをスキップ
    allow(controller).to receive(:check_user_activation)
  end

  describe "GET #index" do
    it "returns a success response" do
      log = create(:log, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      log = create(:log, user: user)
      get :show, params: { id: log.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      log = create(:log, user: user)
      get :edit, params: { id: log.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Log" do
        expect {
          post :create, params: valid_attributes
        }.to change(Log, :count).by(1)
      end

      it "creates a new TackleSelection" do
        expect {
          post :create, params: valid_attributes
        }.to change(TackleSelection, :count).by(1)
      end

      it "redirects to the created log" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(Log.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          log: {
            area: "Updated Area",
            notes: "Updated notes",
            tackle_ids: [ tackle.id ]
          }
        }
      }

      it "updates the requested log" do
        log = create(:log, user: user)
        put :update, params: { id: log.to_param }.merge(new_attributes)
        log.reload
        expect(log.area).to eq("Updated Area")
        expect(log.notes).to eq("Updated notes")
      end

      it "redirects to the log" do
        log = create(:log, user: user)
        put :update, params: { id: log.to_param }.merge(valid_attributes)
        expect(response).to redirect_to(log)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        log = create(:log, user: user)
        put :update, params: { id: log.to_param }.merge(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested log" do
      log = create(:log, user: user)
      expect {
        delete :destroy, params: { id: log.to_param }
      }.to change(Log, :count).by(-1)
    end

    it "redirects to the logs list" do
      log = create(:log, user: user)
      delete :destroy, params: { id: log.to_param }
      expect(response).to redirect_to(logs_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
