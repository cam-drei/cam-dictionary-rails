class ImportData < ApplicationRecord
    has_many :extendeds, foreign_key: :importDataId
end
