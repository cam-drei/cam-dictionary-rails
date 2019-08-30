class AddMainWordToExtended < ActiveRecord::Migration[6.0]
  def change
    add_column :extended, :mainWord, :string, :after => :id 
  end
end
