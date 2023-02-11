module ScrappingData
  class VinsEtMillesimes < Base
    URL = 'https://www.vinsetmillesimes.com/fr/4779-mieux-notes'

    private

    def html_search
      @html_doc.search('.product-container').map { |element| html_element_infos(element) }
    end

    def html_element_infos(element)
      { bottle: bottle_infos(element), price: price_infos(element), tags: tags_infos(element) }
    end

    def bottle_infos(element)
      {
        name: element.search('.product-name').text.strip,
        image_url: element.search('.product_img_link').search('img').attribute('data-src').value,
        expert_rating: find_value_with_regex(prod_desc(element), %r{Robert Parker WA\W*(\w*)/}).to_i
      }
    end

    def price_infos(element)
      {
        value: find_value_with_regex(element.search('.price').text, /(.*)€.*TTC/).delete(' ').to_f,
        website: element.search('.product_img_link').attribute('href').value
      }
    end

    def tags_infos(element)
      {
        alcohol_type: alcohol_type(prod_desc(element)),
        origin: find_value_with_regex(prod_desc(element), /Région\W*(.*)Appellation/).strip
      }
    end

    def find_value_with_regex(search_string, regex)
      search_string.match?(regex) ? search_string.match(regex)[1] : nil
    end

    def prod_desc(element)
      element.search('.product-desc').text
    end

    def alcohol_type(product_description)
      color = find_value_with_regex(product_description, /Couleur\W*(\w*)/)
      case color
      when 'Rouge' then 'red wine'
      when 'Blanc' then 'white wine'
      when 'Rosé' then 'rosé wine'
      else 0
      end
    end
  end
end
