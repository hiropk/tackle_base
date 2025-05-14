require "rails_helper"

RSpec.describe PasswordsMailer, type: :mailer do
  describe "reset" do
    let(:user) { create(:user) }
    let(:mail) { PasswordsMailer.reset(user) }

    before do
      allow(user).to receive(:password_reset_token).and_return("test_reset_token")
    end

    it "renders the headers" do
      expect(mail.subject).to eq("【Tackle Base】パスワード再設定のご案内")
      expect(mail.to).to eq([ user.email_address ])
      expect(mail.from).to eq([ "familiar.slj@gmail.com" ])
      expect(mail[:from].value).to eq('"Tackle Base" <familiar.slj@gmail.com>')
    end

    it "renders the body in HTML format" do
      expect(mail.html_part.body.encoded).to match("パスワード再設定のご案内")
      expect(mail.html_part.body.encoded).to match("パスワードを再設定する")
      expect(mail.html_part.body.encoded).to match("このリンクの有効期限は15分です")
      expect(mail.html_part.body.encoded).to include(edit_password_url("test_reset_token"))
    end

    it "renders the body in text format" do
      expect(mail.text_part.body.encoded).to match("パスワード再設定のご案内")
      expect(mail.text_part.body.encoded).to match("このリンクの有効期限は15分です")
      expect(mail.text_part.body.encoded).to include(edit_password_url("test_reset_token"))
    end
  end
end
