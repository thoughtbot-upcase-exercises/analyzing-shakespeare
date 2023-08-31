require 'nokogiri'
require 'open-uri'

# open from internet instead
xml_file = URI.open('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
xml_doc = Nokogiri::XML(xml_file)

character_lines = Hash.new(0)

xml_doc.xpath('//SPEECH').each do |speech|
    speaker = speech.at_xpath('SPEAKER').text
    if speaker == "ALL"
        next
    end
    lines = speech.xpath('LINE')
    character_lines[speaker] += lines.count
end

character_lines.sort_by {|name, num_lines| num_lines}.reverse.each do |name ,num_lines|
    puts "#{name.downcase.capitalize} #{num_lines}"
end


xml_file.close
