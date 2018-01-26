class Location < ApplicationRecord
  belongs_to :region
  has_many :people

  def self.in_region(region)
    joins(:region).merge(Region.where(name: region))
  end
end
