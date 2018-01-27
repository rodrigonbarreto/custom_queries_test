# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


region_expected = Region.create(name: "expected")
region_other = Region.create(name: "other")

location1 = Location.create(name: "in-expected-region-one", region:region_expected )
location2 = Location.create(name: "in-expected-region-two", region:region_expected )
location3 = Location.create(name: "in-expected-region-one", region:region_expected )
location4 = Location.create(name: "in-other-region", region:region_other )

role1 = Role.create(name: "Role1")
role2 = Role.create(name: "Role2")

person1 = Person.create(name: "person1", location: location1, role: role1)
person2 = Person.create(name: "person2", location: location1, role: role1)
person3 = Person.create(name: "person3", location: location3, role: role1)
person4 = Person.create(name: "person4", location: location3, role: role1)
person5 = Person.create(name: "person5", location: location4, role: role1)
person6 = Person.create(name: "person6", location: location4, role: role1)
