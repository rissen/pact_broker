describe "retrieving the latest tagged pact" do

  let(:path) { "/pacts/provider/Provider/consumer/Consumer/latest/prod"}

  subject { get path; last_response  }
  let(:json_response_body) { JSON.parse(subject.body, symbolize_names: true) }

  before do
    TestDataBuilder.new
      .create_consumer("Consumer")
      .create_provider("Provider")
      .create_consumer_version("1.2.3")
      .create_consumer_version_tag("prod")
      .create_pact
      .create_consumer_version("4.5.6")
      .create_pact
  end

  it "returns the latest tagged pact version" do
    expect(json_response_body[:_links][:self][:href]).to end_with("1.2.3")
  end
end
