require 'nokogiri'
require 'open-uri'

class CalculatePrice

  def self.call(*args, &block)
    new(*args, &block).calculate
  end

  def initialize(organization_id,base_price)
    @organization = Organization.find_by_id(organization_id) if organization_id.present?
    @base_price = base_price
  end

  def calculate
    case @organization.pricing_policy
    when 'Flexible'
      margin = Nokogiri::HTML(open('http://in.reuters.com')
      ).text.gsub(/[^[:word:]]+/, " ").scan(/a/).count
      model_type_price = @base_price + (margin/100)
    when 'Fixed'
      margin = Nokogiri::HTML(open('https://developer.github.com/v3/#http-redirects')
      ).text.gsub(/[^[:word:]]+/, " ").scan(/status/).count
      model_type_price = @base_price + margin
    when 'Prestige'
      margin = Nokogiri::XML(open('https://www.yourlocalguardian.co.uk/sport/rugby/rss/')
      ).xpath('//pubDate').count
      model_type_price = @base_price + margin
    end
    present_result(model_type_price)
  end

  private

  def present_result(model_type_price)
    { name: @organization.name, price: model_type_price }
  end
end
