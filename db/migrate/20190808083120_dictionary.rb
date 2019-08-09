class Dictionary < ActiveRecord::Migration[6.0]
  def up
    create_table :import_data do |t|
      t.column :rumi, :string
      t.column :akharThrah, :string
      t.column :source, :string
      t.column :vietnamese, :string
      t.column :french, :string
      t.column :pronunciation, :string
      t.column :fullDescription, :text
    end

    create_table :extended do |t|
      t.column :rumi, :string
      t.column :akharThrah, :string
      t.column :source, :string
      t.column :vietnamese, :string
      t.column :french, :string
    end
  end

  def down
    drop_table :import_data
    drop_table :extended
  end
end
