class ChangeImportDataToWord < ActiveRecord::Migration[6.0]
  def change
    rename_table :import_data, :word
  end
end
