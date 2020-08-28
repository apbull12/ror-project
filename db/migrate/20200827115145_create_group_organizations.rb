class CreateGroupOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :group_organizations, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.integer :organization_code
      t.uuid :country_id

      t.timestamps
    end
  end
end
