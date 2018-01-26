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

  ## has many




  def self.with_employees_order_by_location_name
    from(self.order_by_location, :people).order(:name).distinct

    #OR
    # Person.from(Person.with_employees, :people).order_by_location_name
  end

  def self.order_by_location
    joins(:location, :employees).merge(Location.order(:name))
  end

  #custom joins

  def self.without_remote_manager
    # joins("LEFT JOIN people managers ON managers.id = people.manager_id").
    # where("people.manager_id IS NULL or people.location_id = managers.location_id")
    #
    joins(<<-SQL).
      LEFT JOIN people managers
      ON managers.id = people.manager_id
    SQL
    where('people.manager_id IS NULL OR managers.name = ?', "local_manager")
  end

  def self.order_by_location_name
    joins(:location).order("locations.name")
  end

  ## ORDER USING MERGE
  # def self.order_by_location_name
  #   joins(:location).merge(Location.order(:name)).order(:name)
  # end

  def self.with_employees
    ## using from
    # from(
    #     joins(:employees).distinct,
    #     :people
    # )
    #
    ##  Like more this option
    Person.from(joins(:employees).distinct, :people)
  end

  #Other ways to do some queries
  # def self.with_employees
  #   joins(:employees).distinct
  #
  #   # maybe under is better
  #   # joins(employees: :manager).merge(Person.order(:name)).distinct
  #   # or
  #   # where(id: Person.pluck(:manager_id)).distinct
  # end

  def self.with_local_coworkers
    from(joins(location: :people).where("people_locations.id <> people.id").distinct, :people)
  end

  #aggregations
  def self.maximum_salary_by_location
    # #option 1
    # joins(:location)
    #     .group('locations.id')
    #     .maximum(:salary)

    #option 2
    group(:location_id).maximum(:salary)

  end

  def self.managers_by_average_salary_difference
    joins(
        'INNER JOIN (' +
            Person.
                joins('INNER JOIN people employees ON employees.manager_id = people.id').
                select('people.id, AVG(employees.salary) as average_salary').
                group('people.id').to_sql +
            ') managers ON managers.id = people.id'
    ).
        select('people.name, (people.salary - managers.average_salary) as salary_diff').
        order('salary_diff DESC')

  end

end
