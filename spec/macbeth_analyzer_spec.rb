require_relative "../lib/macbeth_analyzer"

describe MacbethAnalyzer do
  before do
    fixture_file = File.expand_path("../../spec/fixtures/macbeth.xml", __FILE__)

    allow(Net::HTTP).to receive(:get).and_return(File.new(fixture_file))
  end

  context "#analyze" do
    it "returns number of lines per speaker" do
      analyzer = MacbethAnalyzer.new

      results = analyzer.analyze

      expect(results["MACBETH"]).to eq(719)
      expect(results["BANQUO"]).to eq(113)
      expect(results["DUNCAN"]).to eq(70)
      expect(results["ALL"]).to be_zero
    end
  end
end
