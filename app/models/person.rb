class Person < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id, optional: true
  has_many :employees, class_name: "Person", foreign_key: :manager_id


  def self.in_region(region)
    joins(:location).merge(Location.in_region(region))
  end

  def self.alphabetically_by_region_and_location
    joins(:location).merge(Location.joins(:region).merge(Region.order(:name)).order(:name)).order(:name)
  end

end
