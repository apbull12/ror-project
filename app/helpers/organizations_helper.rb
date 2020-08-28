require 'nokogiri'
require 'open-uri'

module OrganizationsHelper
  def organization_info(id)
    Organization.find_by_id(id).name if id.present?
  end
end
