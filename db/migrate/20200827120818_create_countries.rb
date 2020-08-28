class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.integer :country_code

      t.timestamps
    end
  end
end
