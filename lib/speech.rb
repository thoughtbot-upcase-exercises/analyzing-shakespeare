class Speech
  def initialize(speech_element)
    @speech_element = speech_element
  end

  def speaker
    grouped["SPEAKER"].first.text
  end

  def lines
    grouped["LINE"].map(&:text)
  end

  private

  attr_reader :speech_element

  def grouped
    speech_element.elements.group_by(&:name)
  end
end
