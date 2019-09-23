class AddEnglishToImportData < ActiveRecord::Migration[6.0]
  def change
    add_column :import_data, :english, :string, :after => :french 
  end
end
