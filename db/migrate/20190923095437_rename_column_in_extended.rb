class RenameColumnInExtended < ActiveRecord::Migration[6.0]
  def change
    rename_column :extended, :importDataId, :wordId
  end
end
