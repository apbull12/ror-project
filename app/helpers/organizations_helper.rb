require 'nokogiri'
require 'open-uri'

module OrganizationsHelper
  def calculate_org_price(organization_id,base_price)
    organization = Organization.find_by_id(organization_id)
    case organization.pricing_policy
    when 'Flexible'
      margin = Nokogiri::HTML(open('http://in.reuters.com')).text.gsub(/[^[:word:]]+/, " ").scan(/a/).count
      model_type_price = base_price + (margin/100)
    when 'Fixed'
      margin = Nokogiri::HTML(open('https://developer.github.com/v3/#http-redirects')
      ).text.gsub(/[^[:word:]]+/, " ").scan(/status/).count
      model_type_price = base_price + margin
    when 'Prestige'
      margin = Nokogiri::XML(open('https://www.yourlocalguardian.co.uk/sport/rugby/rss/')
      ).xpath('//pubDate').count
      model_type_price = base_price + margin
    else
      raise 'Organization pricing policy is not matched', 404
    end
    { name: organization.name,price: model_type_price }
  end

  def organization_info(id)
    Organization.find_by_id(id).name if id.present?
  end
end
