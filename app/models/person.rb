class Person < ActiveRecord::Base

  has_many :locations
  has_many :affiliations

  validates_uniqueness_of :first_name, scope: :last_name
  validates_presence_of :first_name
end
