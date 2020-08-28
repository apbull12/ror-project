module GroupOrganizationsHelper
  def group_org_name(id)
    GroupOrganization.find_by_id(id).name
  end
end
