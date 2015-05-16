require_relative "../lib/macbeth_analyzer"

describe Speech do
  context "#speaker" do
    it "returns the <SPEAKER> element's text" do
      speech = Speech.new(speech_element)

      expect(speech.speaker).to eq("Speaker")
    end
  end

  context "#lines" do
    it "returns the <LINE>'s text as an array" do
      speech = Speech.new(speech_element)

      expect(speech.lines).to eq(["Line 1", "Line 2"])
    end
  end

  def speech_element
    document = REXML::Document.new <<SPEECH
<SPEECH>
<SPEAKER>Speaker</SPEAKER>
<LINE>Line 1</LINE>
<LINE>Line 2</LINE>
</SPEECH>
SPEECH
    document.elements.first
  end
end
