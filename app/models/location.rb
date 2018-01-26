class Location < ApplicationRecord
  belongs_to :region
  has_many :people
end
