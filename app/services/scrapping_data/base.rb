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

    def find_value_with_regex(search_string, regex)
      search_string.match?(regex) ? search_string.match(regex)[1] : nil
    end
  end
end
