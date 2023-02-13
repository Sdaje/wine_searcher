class DataBuilder
  def initialize(source_data)
    @source_data = source_data
  end

  def run
    @source_data.each { |element| find_or_generate_instances_from!(element) }
  end

  private

  def find_or_generate_instances_from!(element)
    bottle = Bottle.find_by(name: element[:bottle][:name]).presence || Bottle.new(element[:bottle])
    price = Price.new(element[:price].merge(bottle:))
    return if bottle.invalid? || price.invalid?

    element[:tags].each { |category, value| find_or_generate_tag_from!(category, value, bottle) }
    price.save # save bottle if not persisted [Sylvain Dajeans]
  end

  def find_or_generate_tag_from!(category, value, bottle)
    tag = Tag.find_by(value:).presence || Tag.new(category:, value:)
    bottle_tag = BottleTag.find_by(bottle:, tag:).presence || BottleTag.new(bottle:, tag:)
    return if bottle_tag.persisted?

    bottle_tag.save if tag.valid? # save tag if not persisted [Sylvain Dajeans]
  end
end
