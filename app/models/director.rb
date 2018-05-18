class Director < ApplicationRecord
  validates_uniqueness_of :imdb_id
end
