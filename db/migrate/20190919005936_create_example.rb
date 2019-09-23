class CreateExample < ActiveRecord::Migration[6.0]
  def change
    create_table :example do |t|
      t.column :extendedId, :bigint
      t.column :mainWord, :string
      t.column :rumi, :string
      t.column :akharThrah, :string
      t.column :source, :string
      t.column :vietnamese, :string
      t.column :french, :string
      t.column :english, :string
      t.column :pronunciation, :string
      t.column :fullDescription, :text
    end
  end
end
