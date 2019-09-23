class ImportData < ApplicationRecord
    has_many :extendeds, foreign_key: :importDataId
    has_many :examples, foreign_key: :extendedId, through: :extendeds
end
