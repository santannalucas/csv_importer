class PersonLocation < ActiveRecord::Base

  belongs_to :person
  belongs_to :location

end
