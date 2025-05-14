require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user, activated: true) }
  let(:valid_attributes) {
    {
      email_address: user.email_address,
      password: 'password123'
    }
  }

  let(:invalid_attributes) {
    {
      email_address: 'invalid@example.com',
      password: 'wrongpassword'
    }
  }

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new session" do
        expect {
          post :create, params: valid_attributes
        }.to change(Session, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end

      it "sets the session cookie" do
        post :create, params: valid_attributes
        expect(cookies.signed[:session_id]).to be_present
      end
    end

    context "with invalid params" do
      it "redirects to the login page" do
        post :create, params: invalid_attributes
        expect(response).to redirect_to(new_session_path)
      end

      it "sets an alert message" do
        post :create, params: invalid_attributes
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      # セッションを作成
      @session = user.sessions.create!(
        user_agent: 'Rails Testing',
        ip_address: '0.0.0.0'
      )
      cookies.signed[:session_id] = @session.id
    end

    it "destroys the session" do
      expect {
        delete :destroy
      }.to change(Session, :count).by(-1)
    end

    it "clears the session cookie" do
      delete :destroy
      expect(cookies.signed[:session_id]).to be_nil
    end

    it "redirects to the login page" do
      delete :destroy
      expect(response).to redirect_to(new_session_path)
    end
  end
end
