require "rails_helper"

describe ClientsCompanyCreator do

  describe "#create" do
    let(:emails) { ["test@test.com", "test2@test.com"] }
    let(:subject) { "subject" }
    let(:message) { "message" }

    it do
      expect(Company.count).to eql(0)
      expect(Client.count).to eql(0)
      described_class.new(emails, subject, message).create

      expect(Company.count).to eql(1)
      expect(Client.count).to eql(2)

      created_company = Company.last
      expect(created_company.clients.count).to eql(2)

      Client.all.each do |client|
        expect(client.companies.count).to eq(1)
        expect(client.companies.last).to eq(created_company)
      end
    end
  end

end
