class ChangeRumiToUniqueConstraint < ActiveRecord::Migration[6.0]
  def change
    add_index_options :word, :rumi, unique: true
  end
end
