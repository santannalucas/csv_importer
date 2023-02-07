class Person < ActiveRecord::Base

  has_many :locations
  has_many :affiliations

  validates_uniqueness_of :first_name, :last_name
end
