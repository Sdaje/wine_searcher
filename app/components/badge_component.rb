class BadgeComponent < ViewComponent::Base
  def initialize(label:, color:)
    @label = label
    @color = color
  end

  def call
    tag.span(class: "badge bg-#{@color}") { @label }
  end
end
