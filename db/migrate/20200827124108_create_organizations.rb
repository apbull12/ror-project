class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.string :public_name
      t.string :type
      t.string :pricing_policy
      t.uuid :parent_org_id
      t.uuid :group_organization_id

      t.timestamps
    end
  end
end
