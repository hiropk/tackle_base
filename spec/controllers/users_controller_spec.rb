require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    {
      user: {
        email_address: "test@example.com",
        password: "P@ssword1234",
        password_confirmation: "P@ssword1234"
      }
    }
  }

  let(:invalid_attributes) {
    {
      user: {
        email_address: "",
        password: "password",
        password_confirmation: "different"
      }
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
      it "creates a new User" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "sends an activation email" do
        expect {
          post :create, params: valid_attributes
        }.to have_enqueued_mail(UserMailer, :activation_email)
      end

      it "redirects to the login page" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    let(:user) { create(:user, activated: true) }

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
    end

    it "returns a success response" do
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    let(:user) { create(:user, activated: true) }
    let(:new_attributes) {
      {
        user: {
          email_address: "new@example.com",
          password: "P@ssword1234",
          password_confirmation: "P@ssword1234"
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
    end

    context "with valid params" do
      it "updates the requested user" do
        put :update, params: { id: user.to_param, **new_attributes }
        user.reload
        expect(user.email_address).to eq("new@example.com")
      end

      it "sends an activation email" do
        expect {
          put :update, params: { id: user.to_param, **new_attributes }
        }.to have_enqueued_mail(UserMailer, :activation_email)
      end

      it "redirects to the login page" do
        put :update, params: { id: user.to_param, **new_attributes }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with invalid params" do
      it "redirects to the edit page" do
        put :update, params: { id: user.to_param, **invalid_attributes }
        expect(response).to redirect_to(edit_user_path(user))
      end
    end
  end

  describe "GET #activate" do
    let(:user) { create(:user, activated: false) }

    context "with valid token" do
      it "activates the user" do
        get :activate, params: { token: user.activation_token }
        user.reload
        expect(user.activated).to be true
      end

      it "redirects to the login page" do
        get :activate, params: { token: user.activation_token }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with invalid token" do
      it "redirects to the signup page" do
        get :activate, params: { token: "invalid_token" }
        expect(response).to redirect_to(new_user_path)
      end
    end
  end

  describe "POST #manual_activation" do
    let(:user) { create(:user, activated: false) }

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
    end

    it "sends an activation email" do
      expect {
        post :manual_activation
      }.to have_enqueued_mail(UserMailer, :activation_email)
    end

    it "redirects to the login page" do
      post :manual_activation
      expect(response).to redirect_to(new_session_path)
    end
  end
end
