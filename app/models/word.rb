class Word < ApplicationRecord
    self.table_name = "word"
    has_many :extendeds, foreign_key: :wordId
    has_many :examples, foreign_key: :extendedId, through: :extendeds
end
