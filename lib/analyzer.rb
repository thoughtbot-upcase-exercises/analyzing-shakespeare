# frozen_string_literal: true

require 'services/macbeth_service'
class Analyzer
  class AnalyzerError < StandardError; end
  attr_accessor :result, :data, :calculated_result

  NON_CHARACTER = 'ALL'
  DOC_CONSTANT = 'SPEECH'

  def self.call
    new.call
  end

  def call
    get_data
    parse_data
    calculate_result
    finalize_result
  rescue MacbethService::MacbethServiceError => e
    raise AnalyzerError, "Alas, poor Yorick: #{e.message}"
  end

  def get_data
    @result = MacbethService.call
  end

  def parse_data
    @data = []
    result.search(DOC_CONSTANT).each do |speech|
      data << speech.xpath('SPEAKER', 'LINE').map(&:text)
    end
  end

  def calculate_result
    @calculated_result = Hash.new(0)
    data.each do |element_collection|
      unless element_collection.include?(NON_CHARACTER)
        key = element_collection.first.upcase
        calculated_result[key] += element_collection.length - 1
      end
    end
  end

  def finalize_result
    calculated_result.sort_by { |_character, line_count| [-line_count, _character] }.to_h
  end
end
