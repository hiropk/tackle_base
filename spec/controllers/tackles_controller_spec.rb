require 'rails_helper'

RSpec.describe TacklesController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:rod) { create(:rod, user: user) }
  let(:line) { create(:line, user: user) }
  let(:reel) { create(:reel, user: user, line: line) }
  let(:leader) { create(:leader, user: user) }
  let(:valid_attributes) {
    {
      name: "My Tackle Set",
      rod_id: rod.id,
      reel_id: reel.id,
      knot: "knot_none",
      leader_id: leader.id,
      notes: "Test tackle"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      rod_id: nil,
      reel_id: nil,
      knot: nil,
      leader_id: nil
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
      tackle = create(:tackle, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tackle = create(:tackle, user: user)
      get :show, params: { id: tackle.to_param }
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
      tackle = create(:tackle, user: user)
      get :edit, params: { id: tackle.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tackle" do
        expect {
          post :create, params: { tackle: valid_attributes }
          puts "Tackle errors: #{assigns(:tackle).errors.full_messages}" if assigns(:tackle)&.errors&.any?
        }.to change(Tackle, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { tackle: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { tackle: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Tackle Set",
          notes: "Updated notes"
        }
      }

      it "updates the requested tackle" do
        tackle = create(:tackle, user: user)
        put :update, params: { id: tackle.to_param, tackle: new_attributes }
        tackle.reload
        expect(tackle.name).to eq("Updated Tackle Set")
        expect(tackle.notes).to eq("Updated notes")
      end

      it "redirects to the tackle" do
        tackle = create(:tackle, user: user)
        put :update, params: { id: tackle.to_param, tackle: valid_attributes }
        expect(response).to redirect_to(tackle)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        tackle = create(:tackle, user: user)
        put :update, params: { id: tackle.to_param, tackle: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tackle" do
      tackle = create(:tackle, user: user)
      expect {
        delete :destroy, params: { id: tackle.to_param }
      }.to change(Tackle, :count).by(-1)
    end

    it "redirects to the tackles list" do
      tackle = create(:tackle, user: user)
      delete :destroy, params: { id: tackle.to_param }
      expect(response).to redirect_to(tackles_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
