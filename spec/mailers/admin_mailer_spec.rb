require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "admin_message" do
    let(:mail) { AdminMailer.admin_message }

    it "renders the headers" do
      expect(mail.subject).to eq("Admin message")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
