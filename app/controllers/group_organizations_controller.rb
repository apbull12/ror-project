class GroupOrganizationsController < ApplicationController
  before_action :set_group_organization, only: [:show, :edit, :update, :destroy]
  include CountriesHelper
  include GroupOrganizationsHelper
  include OrganizationsHelper

  # GET /group_organizations
  # GET /group_organizations.json
  def index
    @group_organizations = GroupOrganization.all
  end

  # GET /group_organizations/1
  # GET /group_organizations/1.json
  def show
    @country = Country.find_by_id(@group_organization.country_id)
  end

  # GET /group_organizations/new
  def new
    @group_organization = GroupOrganization.new
  end

  # GET /group_organizations/1/edit
  def edit
  end

  # POST /group_organizations
  # POST /group_organizations.json
  def create
    @group_organization = GroupOrganization.new(group_organization_params)

    respond_to do |format|
      if @group_organization.save
        format.html { redirect_to @group_organization, notice: 'Group organization was successfully created.' }
        format.json { render :show, status: :created, location: @group_organization }
      else
        format.html { render :new }
        format.json { render json: @group_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_organizations/1
  # PATCH/PUT /group_organizations/1.json
  def update
    respond_to do |format|
      if @group_organization.update(group_organization_params)
        format.html { redirect_to @group_organization, notice: 'Group organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_organization }
      else
        format.html { render :edit }
        format.json { render json: @group_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def list_organizations
    ids = params[:group_organization_ids].uniq
    @organizations = []
    ids.each do |id|
      @organizations << GroupOrganization.find_by_id(id).organizations
    end
    render template: 'group_organizations/organizations_list'
  end

  def list_locations
    organizations = GroupOrganization.find_by_id(params[:group_organization_id]).organizations
    @locations = []
    organizations.each do |org|
      @locations << org.locations
    end
    render template: 'group_organizations/locations_list'
  end

  def select_model_type
    @group_organization = GroupOrganization.find_by_id(params[:group_organization_id])
    render partial: 'group_organizations/model_type_form'
  end

  def calculate_price
    @price_info = []
    organization_ids = GroupOrganization.find_by_id(params[:group_organization_id]
    ).organizations.where(pricing_policy: params[:model_type]).pluck(:id)
    base_price = params[:base_price].to_i
    @price_info << organization_ids.map {|id| calculate_org_price(id,base_price) }
    render template: 'group_organizations/show_prices'
  end

  # DELETE /group_organizations/1
  # DELETE /group_organizations/1.json
  def destroy
    @group_organization.destroy
    respond_to do |format|
      format.html { redirect_to group_organizations_url, notice: 'Group organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_organization
      @group_organization = GroupOrganization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_organization_params
      params.require(:group_organization).permit(:name, :organization_code,
                                                 :country_id, :group_organization_ids,
                                                 :group_organization_id, :model_type, :base_price)
    end
end
