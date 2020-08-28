require 'test_helper'

class GroupOrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_organization = group_organizations(:one)
  end

  test "should get index" do
    get group_organizations_url
    assert_response :success
  end

  test "should get new" do
    get new_group_organization_url
    assert_response :success
  end

  test "should create group_organization" do
    assert_difference('GroupOrganization.count') do
      post group_organizations_url, params: { group_organization: { country_id: @group_organization.country_id, name: @group_organization.name, organization_code: @group_organization.organization_code } }
    end

    assert_redirected_to group_organization_url(GroupOrganization.last)
  end

  test "should show group_organization" do
    get group_organization_url(@group_organization)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_organization_url(@group_organization)
    assert_response :success
  end

  test "should update group_organization" do
    patch group_organization_url(@group_organization), params: { group_organization: { country_id: @group_organization.country_id, name: @group_organization.name, organization_code: @group_organization.organization_code } }
    assert_redirected_to group_organization_url(@group_organization)
  end

  test "should destroy group_organization" do
    assert_difference('GroupOrganization.count', -1) do
      delete group_organization_url(@group_organization)
    end

    assert_redirected_to group_organizations_url
  end
end
