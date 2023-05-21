require "spec_helper"
require "macbeth_analyzer"

describe MacbethAnalyzer do
  before do
    stub_request(:get, "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml").
      with(
        headers: {
          'Connection'=>'close',
          'Host'=>'www.ibiblio.org',
          'User-Agent'=>'http.rb/5.1.1'
           }
        ).
        to_return(status: 200, body: File.read("#{RSPEC_ROOT}/support/fixtures/files/macbeth.xml"), headers: {})
  end


  it '#text_downloader downloads text of Macbeth' do
    
    # uri = URI('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')

    # response = Net::HTTP.get(uri)
    response = MacbethAnalyzer.new.text_downloader
    expected_file = Nokogiri::XML(File.read("#{RSPEC_ROOT}/support/fixtures/files/macbeth.xml"))

    expect(response.to_xml).to eq(expected_file.to_xml)
  end

  it "#all_speakers return array of all speakers without duplications" do
    result = MacbethAnalyzer.new.all_speakers
    expected = [
      "First Witch", "Second Witch", "Third Witch", 
      "DUNCAN", "MALCOLM", "Sergeant", "LENNOX", "ROSS", 
      "MACBETH", "BANQUO", "ANGUS", "LADY MACBETH", "Messenger", 
      "FLEANCE", "Porter", "MACDUFF", "DONALBAIN", "Old Man", 
      "ATTENDANT", "First Murderer", "Second Murderer", 
      "Both Murderers", "Servant", "Third Murderer", "Lords", 
      "HECATE", "Lord", "First Apparition", "Second Apparition", 
      "Third Apparition", "LADY MACDUFF", "Son", "Doctor", "Gentlewoman", 
      "MENTEITH", "CAITHNESS", "SEYTON", "SIWARD", "Soldiers", "YOUNG SIWARD"
    ]
    expect(result.count).to eq 40
    expect(result).to eq expected
  end

  it "#speakers_hash should return hash of speakers" do
    result = MacbethAnalyzer.new.speakers_hash
    expected = {"First Witch"=> 0, "Second Witch"=>0, "Third Witch"=>0, 
      "DUNCAN"=>0, "MALCOLM"=>0, "Sergeant"=>0, "LENNOX"=>0, 
      "ROSS"=>0, "MACBETH"=>0, "BANQUO"=>0, "ANGUS"=>0, "LADY MACBETH"=>0,
      "Messenger"=>0, "FLEANCE"=>0, "Porter"=>0, "MACDUFF"=>0, "DONALBAIN"=>0,
      "Old Man"=>0, "ATTENDANT"=>0, "First Murderer"=>0, "Second Murderer"=>0,
      "Both Murderers"=>0, "Servant"=>0, "Third Murderer"=>0, "Lords"=>0, 
      "HECATE"=>0, "Lord"=>0, "First Apparition"=>0, "Second Apparition"=>0, 
      "Third Apparition"=>0, "LADY MACDUFF"=>0, "Son"=>0, "Doctor"=>0, 
      "Gentlewoman"=>0, "MENTEITH"=>0, "CAITHNESS"=>0, "SEYTON"=>0, 
      "SIWARD"=>0, "Soldiers"=>0, "YOUNG SIWARD"=>0}

    expect(result).to eq expected
  end

  it "#lines_counter returns hash with amount of lines per speaker" do
    result = MacbethAnalyzer.new.lines_counter
    expected = {
      "First Witch"=>62, "Second Witch"=>27, "Third Witch"=>27, 
      "DUNCAN"=>70, "MALCOLM"=>212, "Sergeant"=>35, "LENNOX"=>73, 
      "ROSS"=>135, "MACBETH"=>719, "BANQUO"=>113, "ANGUS"=>21, 
      "LADY MACBETH"=>265, "Messenger"=>23, "FLEANCE"=>2, "Porter"=>46, 
      "MACDUFF"=>180, "DONALBAIN"=>10, "Old Man"=>11, "ATTENDANT"=>1, 
      "First Murderer"=>30, "Second Murderer"=>15, "Both Murderers"=>2, 
      "Servant"=>5, "Third Murderer"=>8, "Lords"=>3, "HECATE"=>39, 
      "Lord"=>21, "First Apparition"=>2, "Second Apparition"=>4, 
      "Third Apparition"=>5, "LADY MACDUFF"=>41, "Son"=>20, 
      "Doctor"=>45, "Gentlewoman"=>23, "MENTEITH"=>12, "CAITHNESS"=>11, 
      "SEYTON"=>5, "SIWARD"=>30, "Soldiers"=>1, "YOUNG SIWARD"=>7
    }

    expect(result).to eq expected
  end
end