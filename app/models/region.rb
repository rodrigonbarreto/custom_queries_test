class Region < ApplicationRecord
  has_many :locations
  include Common
end
