# this a project I created with rails to do some tests and custom queries

#rvm 2.4.1 e Rails 5.1.4

#rubocop - ex: rubocop app/models/person.rb
#rspec - ex: rspec spec/models/person_spec.rb

#using console
 * rake db:cread
 * rake db:migrate
 * rake db:seed
 
 You can test class Repository to custom class like.
 PersonRepository.in_region("expected")
 or native methods like
 p = PersonRepository.firt 