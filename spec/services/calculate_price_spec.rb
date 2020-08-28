require 'rails_helper'
require_relative '../../app/services/calculate_price'

RSpec.describe CalculatePrice, type: :integration do
  before(:all) do
    Country.delete_all
    GroupOrganization.delete_all
    Organization.delete_all
    create_required_data
    @base_price = 100
  end

  before(:each) do
    @group_organizations_id = '2a89f425-76e1-4f4c-a875-1c9621f3104e'
  end

  context 'calculate_price service' do
    it 'Should return organization name and price for the pricing policy "Flexible"' do
      price_info = []
      organization_ids = GroupOrganization.find_by_id(@group_organizations_id
      ).organizations.where(pricing_policy: 'Flexible').pluck(:id)
      price_info << organization_ids.map {|id| CalculatePrice.call(id,@base_price) }
      price_info.flatten!
      expect(price_info.count).to eq (2)
      expect(price_info.first[:price]).to be >= (@base_price)
    end

    it 'return organization name and price' do
      price_info = CalculatePrice.call('ce33dec3-da8c-4328-9ecb-c6993ae9b989',@base_price)
      expect([price_info].count).to eq (1)
      expect(price_info[:name]).to eq ('Technology')
      expect(price_info[:price]).to be >= (@base_price)
    end

    it 'Should return organization name and price for the pricing policy "Fixed"' do
      price_info = []
      organization_ids = GroupOrganization.find_by_id(@group_organizations_id
      ).organizations.where(pricing_policy: 'Fixed').pluck(:id)
      price_info << organization_ids.map {|id| CalculatePrice.call(id,@base_price) }
      price_info.flatten!
      expect(price_info.count).to eq (1)
      expect(price_info.first[:price]).to be >= (@base_price)
    end

    it 'Should return organization name and price for the pricing policy "Prestige"' do
      price_info = []
      organization_ids = GroupOrganization.find_by_id(@group_organizations_id
      ).organizations.where(pricing_policy: 'Prestige').pluck(:id)
      price_info << organization_ids.map {|id| CalculatePrice.call(id,@base_price) }
      price_info.flatten!
      expect(price_info.count).to eq (1)
      expect(price_info.first[:price]).to be >= (@base_price)
    end

    it 'Should not return organization name and price for the not valid pricing policy!' do
      price_info = []
      organization_ids = GroupOrganization.find_by_id(@group_organizations_id
      ).organizations.where(pricing_policy: 'Wrong').pluck(:id)
      price_info << organization_ids.map {|id| CalculatePrice.call(id,@base_price) }
      price_info.flatten!
      expect(price_info.empty?).to eq(true)
    end
  end
end
