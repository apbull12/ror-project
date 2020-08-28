require "application_system_test_case"

class GroupOrganizationsTest < ApplicationSystemTestCase
  setup do
    @group_organization = group_organizations(:one)
  end

  test "visiting the index" do
    visit group_organizations_url
    assert_selector "h1", text: "Group Organizations"
  end

  test "creating a Group organization" do
    visit group_organizations_url
    click_on "New Group Organization"

    fill_in "Country", with: @group_organization.country_id
    fill_in "Name", with: @group_organization.name
    fill_in "Organization code", with: @group_organization.organization_code
    click_on "Create Group organization"

    assert_text "Group organization was successfully created"
    click_on "Back"
  end

  test "updating a Group organization" do
    visit group_organizations_url
    click_on "Edit", match: :first

    fill_in "Country", with: @group_organization.country_id
    fill_in "Name", with: @group_organization.name
    fill_in "Organization code", with: @group_organization.organization_code
    click_on "Update Group organization"

    assert_text "Group organization was successfully updated"
    click_on "Back"
  end

  test "destroying a Group organization" do
    visit group_organizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group organization was successfully destroyed"
  end
end
