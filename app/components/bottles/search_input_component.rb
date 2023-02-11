module Bottles
  class SearchInputComponent < ViewComponent::Base
    def initialize(label:, field_tag:, placeholder:)
      @label = label
      @field_tag = field_tag
      @placeholder = placeholder
      @target = @field_tag.to_s.camelize(:lower)
    end
  end
end
