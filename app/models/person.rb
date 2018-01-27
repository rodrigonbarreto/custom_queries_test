# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id, optional: true
  has_many :employees, class_name: "Person", foreign_key: :manager_id


end
