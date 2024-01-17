# frozen_string_literal: true

require './lib/analyzer'
require './lib/services/macbeth_service'
require 'webmock/rspec'
RSpec.describe Analyzer do
  let!(:fixture) { File.expand_path('./services/fixtures/macbeth_response.xml', __dir__) }
  let!(:url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }

  before(:all) do
    WebMock.disable_net_connect!
  end

  context 'success' do
    before do
      stub_request(:get, url).to_return(status: 200, body: File.new(fixture), headers: {})
    end

    it 'parses the data and returns the correct result' do
      result = Analyzer.call

      expect(result).to be_a(Hash)
      expect(result.first).to eq(['MACBETH', 720])
      expect(result['BANQUO']).to eq(113)
      expect(result['ALL']).to eq(nil)
    end
  end

  context 'failure' do
    let!(:error_message) { 'Boom!' }

    before do
      allow(MacbethService).to receive(:call).and_raise(MacbethService::MacbethServiceError.new(error_message))
    end
    it 'rescues MacbethServiceErrror and Raises AnalyzerError' do
      expect { Analyzer.call }.to raise_error(Analyzer::AnalyzerError, "Alas, poor Yorick: #{error_message}")
    end
  end
end
