# frozen_string_literal: true

class PersonRepository < Person

  def self.in_region(region)
    joins(:location).merge(Location.in_region(region))
  end

  def self.alphabetically_by_region_and_location
    joins(:location).merge(Location.joins(:region).merge(Region.order(:name)).order(:name)).order(:name)
  end

  def self.with_employees_order_by_location_name
    from(self.order_by_location, :people).order(:name).distinct
  end

  def self.order_by_location
    joins(:location, :employees).merge(Location.order(:name))
  end

  # custom joins
  def self.without_remote_manager
    joins(<<-SQL).
      LEFT JOIN people managers
      ON managers.id = people.manager_id
    SQL
    where("people.manager_id IS NULL OR managers.name = ?", "local_manager")
  end

  def self.order_by_location_name
    joins(:location).order("locations.name")
  end

  def self.with_employees
    Person.from(joins(:employees).distinct, :people)
  end

  def self.with_local_coworkers
    from(joins(location: :people).where("people_locations.id <> people.id").distinct, :people)
  end

  # Aggregations
  def self.maximum_salary_by_location
    group(:location_id).maximum(:salary)
  end

  def self.managers_by_average_salary_difference
    joins(
        "INNER JOIN (" +
            Person.
                joins("INNER JOIN people employees ON employees.manager_id = people.id").
                select("people.id, AVG(employees.salary) as average_salary").
                group("people.id").to_sql +
            ") managers ON managers.id = people.id"
    ).
        select("people.name, (people.salary - managers.average_salary) as salary_diff").
        order("salary_diff DESC")
  end
end
