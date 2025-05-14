require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activation_email" do
    let(:user) { create(:user, activation_token: "test_token", activated: false) }
    let(:mail) { UserMailer.activation_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("【Tackle Base】アカウントの有効化のお願い")
      expect(mail.to).to eq([ user.email_address ])
      expect(mail.from).to eq([ "familiar.slj@gmail.com" ])
      expect(mail[:from].value).to eq('"Tackle Base" <familiar.slj@gmail.com>')
    end

    it "renders the body in HTML format" do
      expect(mail.html_part.body.encoded).to match("Tackle Base へようこそ！")
      expect(mail.html_part.body.encoded).to match("アカウントを有効化する")
      expect(mail.html_part.body.encoded).to include(activate_user_url(user.activation_token))
    end

    it "renders the body in text format" do
      expect(mail.text_part.body.encoded).to match("Tackle Base へようこそ！")
      expect(mail.text_part.body.encoded).to include(activate_user_url(user.activation_token))
    end
  end
end
