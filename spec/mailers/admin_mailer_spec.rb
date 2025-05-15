require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "individual_message" do
    let(:user) { create(:user, email_address: "user@example.com") }
    let(:admin_user) { create(:user, email_address: "admin@example.com", is_admin: true) }
    let(:subject) { "テストメール" }
    let(:body) { "これはテストメールです。" }
    let(:mail) { AdminMailer.individual_message(user, subject, body, admin_user) }

    it "renders the headers" do
      expect(mail.subject).to eq(subject)
      expect(mail.to).to eq([ user.email_address ])
      expect(mail.from).to eq([ admin_user.email_address ])
      expect(mail[:from].value).to eq("タックルベース管理者 <#{admin_user.email_address}>")
      expect(mail.bcc).to eq([ admin_user.email_address ])
    end

    it "renders the body in both text and HTML formats" do
      expect(mail.text_part.body.encoded).to include(body)
      expect(mail.html_part.body.encoded).to include(body)
    end

    it "includes admin user's signature in both formats" do
      [ "加納 寛之", "遊漁船ファミリア 船長", "タックルベース 開発者" ].each do |text|
        expect(mail.text_part.body.encoded).to include(text)
        expect(mail.html_part.body.encoded).to include(text)
      end
    end
  end
end
