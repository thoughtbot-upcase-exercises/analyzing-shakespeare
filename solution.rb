require 'nokogiri'

# Open and parse the XML file
xml_file = File.open("macbeth.xml")
xml_doc = Nokogiri::XML(xml_file)

character_lines = Hash.new(0)

# Do something with the XML data
xml_doc.xpath('//SPEECH').each do |speech|
    speaker = speech.at_xpath('SPEAKER').text
    line = speech.at_xpath('LINE').text
    character_lines[speaker] += 1
  end

character_lines.sort_by {|k,v| v}.reverse.each do |k,v|
    puts "#{k.downcase.capitalize} #{v}"
    end



# Close the XML file
xml_file.close
