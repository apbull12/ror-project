module CountriesHelper
  def country_name(id)
    Country.find_by_id(id).name
  end
end
