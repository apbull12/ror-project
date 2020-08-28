class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.string :address
      t.uuid :organization_id

      t.timestamps
    end
  end
end
