class RemoveColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :word, :english
    remove_column :example, :wordId, :pronunciation, :fullDescription
  end
end
