class Location < ActiveRecord::Base

  has_many :people, class_name: 'Person'

end
