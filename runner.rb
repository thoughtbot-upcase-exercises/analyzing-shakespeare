# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require './lib/services/macbeth_service'
require './lib/analyzer'

response = Analyzer.call

response.each do |char_pair|
  puts char_pair.join(': ')
end
