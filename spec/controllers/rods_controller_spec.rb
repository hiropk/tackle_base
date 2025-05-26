require 'rails_helper'

RSpec.describe RodsController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:valid_attributes) {
    {
      name: "My Rod",
      brand: "Shimano",
      length: 7.6,
      fishing_type: "sea_bass_minnow",
      power: "medium",
      reel_type: "spining",
      min_weight: 7,
      max_weight: 28,
      purchase_date: Date.current,
      price: 30000,
      notes: "Test rod"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: "",
      length: nil,
      fishing_type: nil,
      power: nil,
      reel_type: nil
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
      rod = create(:rod, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      rod = create(:rod, user: user)
      get :show, params: { id: rod.to_param }
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
      rod = create(:rod, user: user)
      get :edit, params: { id: rod.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Rod" do
        expect {
          post :create, params: { rod: valid_attributes }
        }.to change(Rod, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { rod: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { rod: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Rod",
          notes: "Updated notes"
        }
      }

      it "updates the requested rod" do
        rod = create(:rod, user: user)
        put :update, params: { id: rod.to_param, rod: new_attributes }
        rod.reload
        expect(rod.name).to eq("Updated Rod")
        expect(rod.notes).to eq("Updated notes")
      end

      it "redirects to the rod" do
        rod = create(:rod, user: user)
        put :update, params: { id: rod.to_param, rod: valid_attributes }
        expect(response).to redirect_to(rod)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        rod = create(:rod, user: user)
        put :update, params: { id: rod.to_param, rod: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested rod" do
      rod = create(:rod, user: user)
      expect {
        delete :destroy, params: { id: rod.to_param }
      }.to change(Rod, :count).by(-1)
    end

    it "redirects to the rods list" do
      rod = create(:rod, user: user)
      delete :destroy, params: { id: rod.to_param }
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
