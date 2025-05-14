require 'rails_helper'

RSpec.describe LeadersController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:valid_attributes) {
    {
      name: "My Leader",
      brand: "Sunline",
      leader_rating: 16,
      length: 2,
      material: "fluorocarbon",
      price: 800,
      purchase_date: Date.current,
      notes: "Test leader"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: "",
      leader_rating: nil,
      length: nil,
      material: nil
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
      leader = create(:leader, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      leader = create(:leader, user: user)
      get :show, params: { id: leader.to_param }
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
      leader = create(:leader, user: user)
      get :edit, params: { id: leader.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Leader" do
        expect {
          post :create, params: { leader: valid_attributes }
        }.to change(Leader, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { leader: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { leader: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Leader",
          notes: "Updated notes"
        }
      }

      it "updates the requested leader" do
        leader = create(:leader, user: user)
        put :update, params: { id: leader.to_param, leader: new_attributes }
        leader.reload
        expect(leader.name).to eq("Updated Leader")
        expect(leader.notes).to eq("Updated notes")
      end

      it "redirects to the leader" do
        leader = create(:leader, user: user)
        put :update, params: { id: leader.to_param, leader: valid_attributes }
        expect(response).to redirect_to(leader)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        leader = create(:leader, user: user)
        put :update, params: { id: leader.to_param, leader: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested leader" do
      leader = create(:leader, user: user)
      expect {
        delete :destroy, params: { id: leader.to_param }
      }.to change(Leader, :count).by(-1)
    end

    it "redirects to the leaders list" do
      leader = create(:leader, user: user)
      delete :destroy, params: { id: leader.to_param }
      expect(response).to redirect_to(leaders_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
