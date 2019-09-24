class Extended < ApplicationRecord
    self.table_name = "extended"
    belongs_to :word
    has_many :examples, foreign_key: :extendedId
end
