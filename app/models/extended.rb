class Extended < ApplicationRecord
    self.table_name = "extended"
    belongs_to :import_data
    has_many :examples, foreign_key: :extendedId
end
