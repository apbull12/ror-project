class RenametypeToorgType < ActiveRecord::Migration[6.0]
  def change
    rename_column :organizations, :type, :organization_type
  end
end
