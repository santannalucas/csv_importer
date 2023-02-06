class Person < ActiveRecord::Base

  has_many :locations
  has_many :affiliations

end
