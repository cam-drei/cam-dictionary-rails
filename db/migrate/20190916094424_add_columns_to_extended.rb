class AddColumnsToExtended < ActiveRecord::Migration[6.0]
  def change
    add_column :extended, :importDataId, :bigint, :after => :id 
    add_column :extended, :wordClasses, :string, :after => :mainWord 
    add_column :extended, :english, :string
    add_column :extended, :pronunciation, :string
    add_column :extended, :fullDescription, :text
  end
end
