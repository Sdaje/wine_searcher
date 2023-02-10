module ScrappingData
  class Base
    require "open-uri"
    require "nokogiri"

    def initialize
      url = self.class.const_get(:URL)
      html_file = URI.parse(url).read
      @html_doc = Nokogiri::HTML.parse(html_file, nil, 'utf-8')
    end

    def call
      html_search
    end

    private

    def html_search
      raise NotImplementedError, "#{self.class} did not define method ##{__method__}"
    end
  end
end
