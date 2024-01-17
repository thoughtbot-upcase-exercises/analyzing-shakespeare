# frozen_string_literal: true

require 'faraday'
require 'nokogiri'
class MacbethService
  class MacbethServiceError < StandardError; end
  attr_reader :xml

  URL = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'

  def self.call
    new.call
  end

  def call
    get_data
    prepare_data
  rescue Faraday::ClientError => e
    raise MacbethServiceError, "An error occured: #{e.message}"
  end

  def get_data
    result = Faraday.get(URL)

    @xml = result.body if result.success?
  end

  def prepare_data
    Nokogiri::XML::Document.parse(xml, &:noblanks)
  end
end
