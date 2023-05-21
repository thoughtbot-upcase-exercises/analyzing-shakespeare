require "http"
require "nokogiri"

class MacbethAnalyzer
  attr_reader :text

  def initialize
    @text = text_downloader
  end

  def text_downloader
    url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    response = HTTP.get(url)
    if response.status.success?
      body = response.body
      result_text = Nokogiri::XML::Document.parse(body)
      return result_text
    else
      raise "Error occured: #{response.status}"
    end
  end

  def all_speakers
    speaker_nodes = text.css("SPEAKER")
    speakers = []

    speaker_nodes.each do |node|
      speakers << node.children[0].content
    end

    speakers.uniq - ["ALL"]
  end

  def speakers_hash
    result = {}
    all_speakers.each do |speaker|
      result[speaker] = 0
    end

    result
  end

  def lines_counter
    result = speakers_hash
    text.css("SPEECH").each do |speech_node|
      count = speech_node.children.select {|node| node.name == "LINE"}.count
      name = speech_node.children.select {|node| node.name == "SPEAKER"}.first.child.content


      next unless result.key?(name)

      result[name] = result[name] + count
    end

    result
  end

  def print_result
    lines_counter.each do |key, value|
      puts "#{value} #{key}"
    end
  end
end

MacbethAnalyzer.new.print_result
