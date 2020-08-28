class Organization < ApplicationRecord
  belongs_to :group_organization
  has_many :locations
end
