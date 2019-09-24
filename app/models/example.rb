class Example < ApplicationRecord
    self.table_name = "example"
    belongs_to :extendeds
    belongs_to :words
end
