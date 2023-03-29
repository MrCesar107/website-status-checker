require_relative "../../lib/website_status_checker"

RSpec.describe WebsiteStatusChecker::Client do
  describe "#call" do
    it "returns a success HTTP status message if website is available" do
      uri = "https://www.google.com"

      expect(described_class.new(uri).call).to eq("WEBSITE IS AVAILABLE")
    end

    it "returns a failure HTTP status message if website is unavailable" do
      uri = "https://www.google.com/404"

      expect(described_class.new(uri).call).to eq("WEBSITE IS UNAVAILABLE")
    end

    it "returns a invalid URL message" do
      uri = "invalid_url"

      expect(described_class.new(uri).call).to eq("INVALID URL")
    end
  end
end
