Rails.application.routes.draw do
  get 'organizations/group_organizations_ids', controller: 'group_organizations', action: 'list_organizations'
  get 'locations/group_organization/:group_organization_id', controller: 'group_organizations', action: 'list_locations'
  match 'model_type_prices/:group_organization_id',
        controller: 'group_organizations',
        action: 'calculate_price',
        via: [:get, :post]
  resources :locations
  resources :organizations
  resources :countries
  resources :group_organizations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
