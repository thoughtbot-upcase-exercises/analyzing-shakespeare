# frozen_string_literal: true

require './lib/services/macbeth_service'
require 'webmock/rspec'
RSpec.describe MacbethService do
  let!(:fixture) { File.expand_path('./fixtures/macbeth_response.xml', __dir__) }
  let!(:url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }

  before(:all) do
    WebMock.disable_net_connect!
  end

  context 'success' do
    before do
      stub_request(:get, url).to_return(status: 200, body: File.new(fixture), headers: {})
    end

    it 'retrieves and creates XML document' do
      result = MacbethService.call

      expect(result).to be_a(Nokogiri::XML::Document)
    end
  end

  context 'errors' do
    before do
      error_response = instance_double('Faraday::Response', status: 400, body: 'Error occurred')

      error = Faraday::ClientError.new('Error message', response: error_response)

      allow(Faraday).to receive(:get).with(url).and_raise(error)
    end

    it 'rescues faraday and raises MacbethServiceError' do
      expect { MacbethService.call }.to raise_error(MacbethService::MacbethServiceError)
    end
  end
end
