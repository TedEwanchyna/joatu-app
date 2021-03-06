require 'acceptance_spec_helper'

resource 'Search' do
  if ENV.key? "API_SUBDOMAIN"
    root_url = "http://#{ENV.fetch("API_SUBDOMAIN")}.joatu.com"
  else
    root_url = "http://joatu.com"
  end

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }

  parameter :search, "An array of tags to search for."

  get "#{root_url}/search/offers" do
    it_behaves_like "it requires authentication"

    let(:search) { ["foo"] }

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns a 200 response" do
        do_request
        expect(status).to eq 200
      end
    end
  end
end
