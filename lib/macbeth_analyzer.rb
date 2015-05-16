require "net/http"
require "rexml/document"
require "speech"

class MacbethAnalyzer
  MACBETH_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  def analyze
    results = {}
    each_speech_element do |speech_element|
      speech = Speech.new(speech_element)
      results[speech.speaker] ||= 0
      results[speech.speaker] += speech.lines.count
    end
    results
  end

  private

  def each_speech_element(&block)
    xml_doc.elements.each("PLAY/ACT/SCENE/SPEECH", &block)
  end

  def xml_doc
    REXML::Document.new macbeth_xml
  end

  def macbeth_xml
    Net::HTTP.get URI(MACBETH_URL)
  end
end
