module Bottles
  class TagsComponent < ViewComponent::Base
    def initialize(tags:)
      @tags = tags
    end

    def tag_color(tag)
      if tag.alcohol_type?
        alcohol_type_tag_color(tag.value)
      elsif tag.origin?
        'primary'
      else
        'secondary'
      end
    end

    def alcohol_type_tag_color(tag_value)
      case tag_value
      when 'red wine' then 'danger'
      when 'white wine' then 'secondary'
      else 'warning'
      end
    end
  end
end
