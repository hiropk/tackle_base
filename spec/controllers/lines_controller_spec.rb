require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:valid_attributes) {
    {
      name: "My Line",
      brand: "YGK",
      pe_rating: 1.2,
      length: 150,
      strand_count: "four",
      marker: true,
      price: 3000,
      purchase_date: Date.current,
      notes: "Test line"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: "",
      pe_rating: nil,
      length: nil,
      strand_count: nil
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
      line = create(:line, user: user)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      line = create(:line, user: user)
      get :show, params: { id: line.to_param }
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
      line = create(:line, user: user)
      get :edit, params: { id: line.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Line" do
        expect {
          post :create, params: { line: valid_attributes }
        }.to change(Line, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { line: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { line: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Line",
          notes: "Updated notes"
        }
      }

      it "updates the requested line" do
        line = create(:line, user: user)
        put :update, params: { id: line.to_param, line: new_attributes }
        line.reload
        expect(line.name).to eq("Updated Line")
        expect(line.notes).to eq("Updated notes")
      end

      it "redirects to the line" do
        line = create(:line, user: user)
        put :update, params: { id: line.to_param, line: valid_attributes }
        expect(response).to redirect_to(line)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        line = create(:line, user: user)
        put :update, params: { id: line.to_param, line: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested line" do
      line = create(:line, user: user)
      expect {
        delete :destroy, params: { id: line.to_param }
      }.to change(Line, :count).by(-1)
    end

    it "redirects to the lines list" do
      line = create(:line, user: user)
      delete :destroy, params: { id: line.to_param }
      expect(response).to redirect_to(lines_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
