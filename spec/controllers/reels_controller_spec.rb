require 'rails_helper'

RSpec.describe ReelsController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:line) { create(:line, user: user) }
  let(:valid_attributes) {
    {
      name: "My Reel",
      brand: "Shimano",
      reel_type: "spining",
      gear_type: "normal_gear",
      line_id: line.id,
      price: 10000,
      purchase_date: Date.current,
      notes: "Test reel"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: "",
      reel_type: nil,
      gear_type: nil,
      line_id: nil
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
    allow(controller).to receive(:reject_direct_access)
  end

  describe "GET #index" do
    it "returns a success response" do
      reel = create(:reel, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      reel = create(:reel, user: user)
      get :show, params: { id: reel.to_param }
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
      reel = create(:reel, user: user)
      get :edit, params: { id: reel.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Reel" do
        expect {
          post :create, params: { reel: valid_attributes }
        }.to change(Reel, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { reel: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { reel: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Reel",
          notes: "Updated notes"
        }
      }

      it "updates the requested reel" do
        reel = create(:reel, user: user)
        put :update, params: { id: reel.to_param, reel: new_attributes }
        reel.reload
        expect(reel.name).to eq("Updated Reel")
        expect(reel.notes).to eq("Updated notes")
      end

      it "redirects to the reel" do
        reel = create(:reel, user: user)
        put :update, params: { id: reel.to_param, reel: valid_attributes }
        expect(response).to redirect_to(reel)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        reel = create(:reel, user: user)
        put :update, params: { id: reel.to_param, reel: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested reel" do
      reel = create(:reel, user: user)
      expect {
        delete :destroy, params: { id: reel.to_param }
      }.to change(Reel, :count).by(-1)
    end

    it "redirects to the reels list" do
      reel = create(:reel, user: user)
      delete :destroy, params: { id: reel.to_param }
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
