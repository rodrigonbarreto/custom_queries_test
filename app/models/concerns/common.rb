module Common
   extend ActiveSupport::Concern

   #methods for normal object
   def hello
     "hello"
   end

   # methods for class ex Region.by_name("xpto")
   module ClassMethods
     def by_name(name)
       where(name: name)
     end
   end
end