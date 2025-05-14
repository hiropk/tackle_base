require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  let(:user) { create(:user, activated: true) }

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with existing email" do
      it "sends a password reset email" do
        expect {
          post :create, params: { email_address: user.email_address }
        }.to have_enqueued_mail(PasswordsMailer, :reset)
      end

      it "redirects to the login page" do
        post :create, params: { email_address: user.email_address }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with non-existing email" do
      it "does not send a password reset email" do
        expect {
          post :create, params: { email_address: "nonexistent@example.com" }
        }.not_to have_enqueued_mail(PasswordsMailer, :reset)
      end

      it "redirects to the login page" do
        post :create, params: { email_address: "nonexistent@example.com" }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "GET #edit" do
    context "with valid token" do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)
      end

      it "returns a success response" do
        get :edit, params: { token: "valid_token" }
        expect(response).to be_successful
      end
    end

    context "with invalid token" do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_raise(ActiveSupport::MessageVerifier::InvalidSignature)
      end

      it "redirects to the new password page" do
        get :edit, params: { token: "invalid_token" }
        expect(response).to redirect_to(new_password_path)
      end
    end
  end

  describe "PUT #update" do
    let(:new_password) { "P@ssword1234" }
    let(:valid_attributes) {
      {
        token: "valid_token",
        password: {
          password: new_password,
          password_confirmation: new_password
        }
      }
    }

    let(:invalid_attributes) {
      {
        token: "valid_token",
        password: {
          password: new_password,
          password_confirmation: "different"
        }
      }
    }

    context "with valid params" do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)
        allow(user).to receive(:update).with(any_args).and_return(true)
        allow(user).to receive(:authenticate).with(new_password).and_return(true)
      end

      it "updates the user's password" do
        put :update, params: valid_attributes
        user.reload
        expect(user.authenticate(new_password)).to be_truthy
      end

      it "redirects to the login page" do
        put :update, params: valid_attributes
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with invalid params" do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)
        allow(user).to receive(:update).with(any_args).and_return(false)
      end

      it "redirects to the edit password page" do
        put :update, params: invalid_attributes
        expect(response).to redirect_to(edit_password_path(token: invalid_attributes[:token]))
      end
    end

    context "with invalid token" do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_raise(ActiveSupport::MessageVerifier::InvalidSignature)
      end

      it "redirects to the new password page" do
        put :update, params: valid_attributes
        expect(response).to redirect_to(new_password_path)
      end
    end
  end
end
